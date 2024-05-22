import 'dart:typed_data';
import 'package:customervendorkotlinflutter/controllers/authenticationcontroller.dart';
import 'package:customervendorkotlinflutter/utilities/showsnackbar.dart';
import 'package:customervendorkotlinflutter/views/customers/authentications/loginscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/maincustomerscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomerRegisterScreen extends StatefulWidget {
  @override
  State<CustomerRegisterScreen> createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  final AuthenticationController _authenticationController =
      AuthenticationController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String email;

  late String userName;

  late String phoneNumber;

  late String password;

  bool _isLoading = false;

  Uint8List? _image;

  //function
  _signUpUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      String response = await _authenticationController
          .signUpUsers(email, userName, phoneNumber, password, _image)
          .whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
        });
      });
      if (response == 'successful') {
        mySnackBar(context, 'Account created successfully');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const MainCustomerScreen();
        }));
      } else if (response == 'weak-password') {
        setState(() {
          mySnackBar(context, response);
        });
      } else if (response == 'email-already-in-use') {
        setState(() {
          mySnackBar(context, response);
        });
      } else {
        setState(() {
          mySnackBar(context, response);
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      return mySnackBar(context, 'Please fill all the fields');
    }
  }

  selectGalleryImage() async {
    Uint8List image =
        await _authenticationController.pickProfileImage(ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  selectCameraImage() async {
    Uint8List image =
        await _authenticationController.pickProfileImage(ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Create Customer\'s Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.green,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.green,
                            backgroundImage: null,
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                    Positioned(
                      child: IconButton(
                        onPressed: () {
                          selectGalleryImage();
                        },
                        icon: const Icon(
                          CupertinoIcons.photo,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Email',
                      hintText: 'example: johndoe@gmail.com',
                      prefix: Icon(Icons.email),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      userName = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Full Name',
                      hintText: 'example: John Doe',
                      prefix: Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Phone Number',
                      hintText: 'example: 0712345678',
                      prefix: Icon(Icons.phone),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Password',
                      hintText: 'Password',
                      prefix: Icon(Icons.lock),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        userName = usernameController.text;
                        email = emailController.text;
                        password = passwordController.text;
                      });
                    }
                    _signUpUsers();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: Center(
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text('Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                              )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CustomerLogInScreen();
                        }));
                      },
                      child: const Text(
                        'LogIn',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
