import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  _uploadProfileProfileImageToStorage(Uint8List? image) async {
    Reference _storageRef =
        _storage.ref().child('ProfileImages').child(_auth.currentUser!.uid);
    UploadTask _uploadTask = _storageRef.putData(image!);

    TaskSnapshot snapshot = await _uploadTask;
    String _downloadUrl = await snapshot.ref.getDownloadURL();
    return _downloadUrl;
  }

  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    final XFile? _image =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (_image != null) {
      return await _image.readAsBytes();
    } else {
      return ('No Image selected');
    }
  }

  Future<String> signUpUsers(String email, String userName, String phoneNumber,
      String password, Uint8List? image) async {
    String response = 'an error occurred';

    try {
      if (email.isNotEmpty &&
          userName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //create the user
        UserCredential credentials = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String profileImageUrl =
            await _uploadProfileProfileImageToStorage(image);

        await _firestore
            .collection('Customers')
            .doc(credentials.user!.uid)
            .set({
          'email': email,
          'userName': userName,
          'phoneNumber': phoneNumber,
          'password': password,
          'customerId': credentials.user!.uid,
          'address': '',
          'profileImageUrl': profileImageUrl,
        });
        response = 'successful';
      } else {
        response = 'please fill all the fields';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        response = 'The account already exists for that email.';
      }
      response = e.toString();
    }
    return response;
  }

  Future<String> logInUsers(String email, String password) async {
    String response = 'an error occurred';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        //sign in the user
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        response = 'successful';
      } else {
        response = 'please fill all the fields';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        response = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        response = 'Wrong password provided for that user.';
      } else if (e.code == 'user-disabled') {
        response = 'The user account has been disabled by an administrator.';
      } else {
      }
      response = e.toString();
    }
    return response;
  }
}
