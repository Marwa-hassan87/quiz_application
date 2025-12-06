import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
    Uint8List? profileImage,
  }) async {
    String res = 'Some error occured';
    try {
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String? base65Image= profileImage!=null ? base64Encode(profileImage) : null;
        await _firestore.collection('userData').doc(credential.user!.uid).set({
          'name': name,
          'uid': credential.user!.uid,
          'email': email,
          'score': 0,
          'photoBase64':base65Image
        });
        res = 'success';
      } else {
        res = 'please fill all fields';
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  ////////////---Login---////////////
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      } else {
        res = 'please fill all fields';
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
