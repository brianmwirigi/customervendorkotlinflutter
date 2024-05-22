import 'dart:io';
import 'package:customervendorkotlinflutter/providers/productprovider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ImagesTabScreen extends StatefulWidget {
  @override
  State<ImagesTabScreen> createState() => _ImagesTabScreenState();
}

class _ImagesTabScreenState extends State<ImagesTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  //code to pick multiple images from gallery
  final ImagePicker productImagePicker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final List<File> _productImage = []; //stores picked images

  //stores pictures downloadable url to firebase firestore//stores pictures downloadable url to firebase firestore
  final List<String> _productImageUrlList = [];

  bool _isSave = false;

  chooseImage() async {
    EasyLoading.show(status: 'Loading Image');
    final pickedFile =
        await productImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return ('no image picked');
    } else {
      setState(() {
        _productImage.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: _productImage.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 3),
            itemBuilder: (context, index) {
              return index == 0
                  ? Center(
                      child: IconButton(
                        onPressed: () {
                          chooseImage().whenComplete(
                            () => EasyLoading.dismiss(),
                          );
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(_productImage[index - 1]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () async {
              EasyLoading.show(status: 'Saving Images');
              //code to upload images to firebase storage
              for (var img in _productImage) {
                Reference productImageReference =
                    _storage.ref().child('productImages').child(const Uuid().v4());
                await productImageReference.putFile(img).whenComplete(() async {
                  await productImageReference.getDownloadURL().then((value) {
                    setState(() {
                      _isSave = true;
                      _productImageUrlList.add(value);
                      _productProvider.getFormData(
                          productImageUrlList: _productImageUrlList);
                      EasyLoading.dismiss();
                    });
                  });
                });
              }
            },
            child: _productImage.isNotEmpty
                ? Text(
                    _isSave ? 'Uploaded' : 'Upload',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 4),
                  )
                : const Text(''),
          )
        ],
      ),
    );
  }
}
