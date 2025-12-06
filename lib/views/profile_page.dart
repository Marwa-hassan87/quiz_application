// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
// import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_application/views/login_page.dart';
import 'package:quiz_application/widgets/my_button.dart';
import 'package:quiz_application/widgets/snakbar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = true;
  Map<String, dynamic>? userData;
  Uint8List? profileImageBytes;
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (user == null) return;
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('userData')
          .doc(user!.uid)
          .get();
      if (documentSnapshot.exists) {
        setState(() {
          userData = documentSnapshot.data() as Map<String, dynamic>;
          if (userData?['photoBase64'] != null) {
            profileImageBytes = base64Decode(userData!['photoBase64']);
          }
          isLoading = false;
        });
      } else {
        setState(() {
          userData = null;
          isLoading = true;
        });
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = true;
        userData = null;
      });
    }
  }

  Future<void> updateProfileImage(Uint8List imageBytes) async {
    if (user == null) return;
    try {
      String base64Image = base64Encode(imageBytes);
      await FirebaseFirestore.instance
          .collection('userData')
          .doc(user!.uid)
          .set({'photoBase64': base64Image}, SetOptions(merge: true));
      setState(() {
        profileImageBytes = imageBytes;
      });
      showSnackBar(context, 'Profile Image updated successfully');
    } catch (e) {
      showSnackBar(context, 'failed to update profile image : $e');
    }
  }

  Future<void> pickImage() async {
    final returnImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (returnImage == null) return;
    final imageBytes = await returnImage.readAsBytes();
    if (!mounted) return;
    await updateProfileImage(imageBytes);
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userData == null
          ? Center(child: Text('user data not found'))
          : Padding(
              padding: EdgeInsets.only(top: 100, left: 20, right: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: profileImageBytes != null
                          ? MemoryImage(profileImageBytes!)
                          : NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                            ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 15,
                          child: Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${userData!['name']}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Score: ${userData!['score']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: MyButton(onTap: _signOut, buttonText: 'Logout'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
