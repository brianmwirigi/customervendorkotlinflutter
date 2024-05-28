import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customervendorkotlinflutter/utilities/showsnackbar.dart';
import 'package:customervendorkotlinflutter/vendors/views/screens/earningscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';

class VendorWithdrawalScreen extends StatefulWidget {
  @override
  State<VendorWithdrawalScreen> createState() => _VendorWithdrawalScreenState();
}

class _VendorWithdrawalScreenState extends State<VendorWithdrawalScreen> {
  late String amount;

  late String accountHolderName;

  late String mobileNumber;

  late String bankName;

  late String bankAccountName;

  late String bankAccountNumber;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Center(
          child: Text(
            'WITHDRAWAL SCREEN',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Name of Account Holder';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        accountHolderName = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'example: John Doe',
                      labelText: 'Enter Name of Account Holder',
                      labelStyle: TextStyle(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Amount to Withdraw in kes';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        amount = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'example: 5000',
                      labelText: 'Enter Amount to Withdraw in kes',
                      labelStyle: TextStyle(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Mobile Number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        mobileNumber = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'example: 254790249990',
                      labelText: 'Enter Mobile Number',
                      labelStyle: TextStyle(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Name of Bank';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        bankName = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'example: Barclays Bank',
                      labelText: 'Enter Name of Bank',
                      labelStyle: TextStyle(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Bank Account Name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        bankAccountName = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'example: John Doe',
                      labelText: 'Enter Bank Account Name',
                      labelStyle: TextStyle(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Bank Account Number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        bankAccountNumber = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'example: 1234567890',
                      labelText: 'Enter Account Number',
                      labelStyle: TextStyle(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'Withdrawing....');
                      mySnackBar(
                          context, 'Withdrawal Request Sent Successfully');
                      if (_formKey.currentState!.validate()) {
                        //send data to the backend
                        await _firestore
                            .collection('VendorWithdrawals')
                            .doc(Uuid().v4())
                            .set({
                          'amount': amount,
                          'accountHolderName': accountHolderName,
                          'mobileNumber': mobileNumber,
                          'bankName': bankName,
                          'bankAccountName': bankAccountName,
                          'bankAccountNumber': bankAccountNumber,
                        });
                        //clear the form
                        EasyLoading.dismiss();
                        EasyLoading.showSuccess(
                            'Withdrawal Request Sent Successfully');
                        _formKey.currentState!.reset();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return  EarningScreen();
                        }));

                        //show a snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Withdrawal Request Sent Successfully'),
                          ),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'WITHDRAW',
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
