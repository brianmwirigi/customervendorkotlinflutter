import 'dart:typed_data';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:customervendorkotlinflutter/vendors/controllers/vendorregistrationcontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class VendorRegistrationScreen extends StatefulWidget {
  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _authentication = FirebaseAuth.instance;
  final VendorRegistrationController _vendorRegistrationController =
      VendorRegistrationController();

  late String businessName;
  late String email;
  late String phoneNumber;
  late String taxNumber;
  late String countryValue;
  late String stateValue;
  late String cityValue;
  Uint8List? _image;

  final bool _isLoading = false;

  selectGalleryImage() async {
    EasyLoading.show(status: 'Loading Image');
    Uint8List vendorImage = await _vendorRegistrationController
        .pickStoreImage(ImageSource.gallery)
        .whenComplete(() {
      EasyLoading.dismiss();
    });
    setState(() {
      _image = vendorImage;
    });
  }

  selectCameraImage() async {
    EasyLoading.show(status: 'Loading Image');
    Uint8List vendorImage = await _vendorRegistrationController
        .pickStoreImage(ImageSource.camera)
        .whenComplete(() {
      EasyLoading.dismiss();
    });
    setState(() {
      _image = vendorImage;
    });
  }

  final List<String> _taxOptions = ['YES', 'NO'];

  String? _taxStatus = 'NO';

  _saveVendorDetails() async {
    EasyLoading.show(
        status: 'Saving Vendor Details', maskType: EasyLoadingMaskType.black);
    if (_formKey.currentState!.validate()) {
      await _vendorRegistrationController
          .registerVendor(
        businessName: businessName,
        email: email,
        phoneNumber: phoneNumber,
        countryValue: countryValue,
        stateValue: stateValue,
        cityValue: cityValue,
        taxRegistered: _taxStatus!,
        taxNumber: taxNumber,
        storeImage: _image,
      )
          .whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _formKey.currentState!.reset();
          _image = null;
        });
      });
    } else {
      EasyLoading.dismiss();
      return 'Please fill all fields';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.green,
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.green,
                          Colors.white,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 10,
                                  ),
                                ]),
                            child: _image != null
                                ? Image.memory(_image!, fit: BoxFit.contain)
                                : IconButton(
                                    icon: const Icon(CupertinoIcons.photo),
                                    onPressed: () {
                                      selectGalleryImage();
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text('Vendor Registration'),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) => businessName = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your  Business Name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Business Name',
                        hintText: 'example: Beyond Fruits  Ltd',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) => email = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Enter Email Address',
                        hintText: 'example: beyondfruits@gmail.com',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) => phoneNumber = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        hintText: 'example: 0712345678',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SelectState(onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      }, onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      }, onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                        });
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tax registered',
                            style: TextStyle(fontSize: 20),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: 200,
                              child: DropdownButtonFormField(
                                  hint: const Text('Select Tax Status'),
                                  items: _taxOptions
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _taxStatus = value;
                                      if (_taxStatus == 'NO') {
                                        taxNumber = 'N/A';
                                      }
                                    });
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    _taxStatus == 'YES'
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              onChanged: (value) => taxNumber = value,
                              decoration: const InputDecoration(
                                labelText: 'Tax Number',
                                hintText: 'example: 1234567890',
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        _saveVendorDetails();
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 300,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'SAVE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 4),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
