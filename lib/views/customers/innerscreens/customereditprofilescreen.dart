import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CustomerEditProfileScreen extends StatefulWidget {
  final dynamic customerData;

  CustomerEditProfileScreen({super.key, this.customerData});

  @override
  State<CustomerEditProfileScreen> createState() =>
      _CustomerEditProfileScreenState();
}

class _CustomerEditProfileScreenState extends State<CustomerEditProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  String? address;

  @override
  void initState() {
    setState(() {
      _userNameController.text = widget.customerData['userName'];
      _emailController.text = widget.customerData['email'];
      _phoneNumberController.text = widget.customerData['phoneNumber'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Center(
          child: Text('EDIT PROFILE',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 5,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.green,
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: _userNameController,
                            decoration: const InputDecoration(
                              labelText: 'Enter Full Name',
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            enabled: false,
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Enter Email',
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: _phoneNumberController,
                            decoration: const InputDecoration(
                              labelText: 'Enter PhoneNumber',
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                address = value;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Enter Address',
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () async {
                  EasyLoading.show(status: 'Updating Profile...');
                  await _firestore
                      .collection('Customers')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    'userName': _userNameController.text,
                    'email': _emailController.text,
                    'phoneNumber': _phoneNumberController.text,
                    'address': address,
                  }).whenComplete(() {
                    EasyLoading.dismiss();
                    EasyLoading.showSuccess('Profile Updated Successfully');
                    Navigator.pop(context);
                  }).catchError((error) {
                    EasyLoading.showError(error.toString());
                  });
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Center(
                      child: Text(
                        'UPDATE PROFILE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
