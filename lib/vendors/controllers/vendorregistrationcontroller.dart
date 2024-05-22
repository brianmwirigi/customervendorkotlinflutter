import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class VendorRegistrationController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _authentication = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //function to store image in firebase storage

  _uploadVendorImageToStorage(Uint8List? image) async {
    Reference reference = _storage
        .ref()
        .child('StoreImages')
        .child(_authentication.currentUser!.uid);
    UploadTask uploadTask = reference.putData(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //function to store image in firebase storageends

  //function to pick store image from gallery or camera
  pickStoreImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _vendorImageFile = await _imagePicker.pickImage(source: source);

    if (_vendorImageFile != null) {
      return await _vendorImageFile.readAsBytes();
    } else {
      return ('no image selected');
    }
  }

  //function to pick store image from gallery or camera ends here

  //FUNTION TO SAVE VENDOR DATA TO FIRESTORE

  Future<String> registerVendor({
    required String businessName,
    required String email,
    required String phoneNumber,
    required String countryValue,
    required String stateValue,
    required String cityValue,
    required String taxRegistered,
    required String taxNumber,
    Uint8List? storeImage,
  }) async {
    String response = 'error occured';

    try {
      //save data to cloud firestore

      await _firestore
          .collection('Vendors')
          .doc(_authentication.currentUser!.uid)
          .set({
        'businessName': businessName,
        'email': email,
        'phoneNumber': phoneNumber,
        'countryValue': countryValue,
        'stateValue': stateValue,
        'cityValue': cityValue,
        'taxRegistered': taxRegistered,
        'taxNumber': taxNumber,
        'storeImage': await _uploadVendorImageToStorage(storeImage),
        'approved': false,
        'vendorId': _authentication.currentUser!.uid,
      });
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

//FUNCTION TO SAVE VENDOR DATA ENDS HERE
}
