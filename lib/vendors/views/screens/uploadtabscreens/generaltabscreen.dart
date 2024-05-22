import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customervendorkotlinflutter/providers/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GeneralTabScreen extends StatefulWidget {
  @override
  State<GeneralTabScreen> createState() => _GeneralTabScreenState();
}

class _GeneralTabScreenState extends State<GeneralTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> _categoryList = []; //stores list of categories

  _getCategoryName() {
    return _firestore
        .collection('Categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      }
    });
  }

  @override
  void initState() {
    _getCategoryName();
    super.initState();
  }

  String formattedDate(date) {
    final outputDateFormat = DateFormat('dd/MM/yyyy');
    final outputDate = outputDateFormat.format(date);
    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Product name';
                }
                return null;
              },
              onChanged: (value) {
                _productProvider.getFormData(productName: value);
              },
              decoration: const InputDecoration(
                labelText: 'Enter Product Name',
                hintText: 'example: Pineapple',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Product Price in kes';
                }
                return null;
              },
              onChanged: (value) {
                _productProvider.getFormData(productPrice: int.parse(value));
              },
              decoration: const InputDecoration(
                labelText: 'Enter Product Price in Kes',
                hintText: 'example: 500',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Product Quantity in gram\'s';
                }
                return null;
              },
              onChanged: (value) {
                _productProvider.getFormData(
                    productQuantity: int.parse(value));
              },
              decoration: const InputDecoration(
                labelText: 'Enter Product quantity in gram\'s',
                hintText: 'example: 10000',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            DropdownButtonFormField(
              hint: const Text('Select Product Category'),
              elevation: 5,
              decoration: InputDecoration(
                  labelText: 'Select Product Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              items: _categoryList.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _productProvider.getFormData(productCategory: value);
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Product Description';
                }
                return null;
              },
              onChanged: (value) {
                _productProvider.getFormData(productDescription: value);
              },
              minLines: 3,
              maxLines: 5,
              maxLength: 500,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Enter Product Description',
                hintText:
                    'example: Organic Fresh Pineapple from the kakuzi farm in thika county ....',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(5000))
                        .then((value) {
                      setState(() {
                        _productProvider.getFormData(
                            productScheduleDate: value);
                      });
                    });
                  },
                  child: const Text(
                    'Schedule Date: ',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                    ),
                  ),
                ),
                if (_productProvider.productData['productScheduleDate'] != null)
                  Text(
                    formattedDate(
                      _productProvider.productData['productScheduleDate'],
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
