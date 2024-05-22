import 'package:customervendorkotlinflutter/controllers/authenticationcontroller.dart';
import 'package:customervendorkotlinflutter/utilities/showsnackbar.dart';
import 'package:customervendorkotlinflutter/views/customers/authentications/forgotpasswordscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/authentications/registerscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/maincustomerscreen.dart';
import 'package:flutter/material.dart';

class CustomerLogInScreen extends StatefulWidget {
  @override
  State<CustomerLogInScreen> createState() => _CustomerLogInScreenState();
}

class _CustomerLogInScreenState extends State<CustomerLogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthenticationController _authenticationController =
      AuthenticationController();
  TextEditingController useremailController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();

  late String email;

  late String password;

  bool _isLoading = false;

  _logInUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      //call the function to log in the user
      String response = await _authenticationController
          .logInUsers(email, password)
          .whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
        });
      });

      if (response == 'successful') {
        mySnackBar(context, 'LogIn successfully');
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const MainCustomerScreen();
        }));
      } else if (response == 'user-notfound') {
        return mySnackBar(context, response);
      } else if (response == 'wrong-password') {
        return mySnackBar(context, response);
      } else {
        setState(() {
          _isLoading = false;
          return mySnackBar(context, response);
        });
      }
      return mySnackBar(context, 'Please fill all the fields');
    }
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
                const Text(
                  'Login Customer Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: useremailController,
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
                      labelText: 'Enter Email Address',
                      hintText: 'example: johndoe@gmail.com',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: userpasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Enter Password',
                      hintText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Forgot Password?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ForgotPasswordScreen();
                        }));
                      },
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        email = useremailController.text;
                        password = userpasswordController.text;
                      });
                    }
                    _logInUsers();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text('LogIn',
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
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CustomerRegisterScreen();
                        }));
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
