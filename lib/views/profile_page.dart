// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_application/views/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = true;
  Map<String, dynamic>? userData;
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

  Future<void> signOut() async {
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
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                      ),
                    ),
                  ),
                  Text('Name: ${userData!['name']}'),
                  Text('Email: ${userData!['email']}'),
                  Text('Score: ${userData!['score']}'),
                ],
              ),
            ),
    );
  }
}
