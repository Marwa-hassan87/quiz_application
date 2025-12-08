import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_application/views/navbar_category_page.dart';
import 'package:quiz_application/widgets/my_button.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  const ResultPage({
    super.key,
    required this.score,
    required this.totalQuestions,
  });
  Future<void> updateUserScore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      DocumentReference userRef = FirebaseFirestore.instance
          .collection('userData')
          .doc(user.uid);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userRef);
        if (!snapshot.exists) {
          throw Exception('user doesn\'t exist');
        }
        int existingScore = snapshot['score'] ?? 0;
        transaction.update(userRef, {'score': existingScore + score});
      });
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        title: Text('Your Result'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              // Center(
              //   child: Stack(
              //     children: [
              //       Lottie.network(
              //         'https://lottie.host/9ee9e67e-56ec-49d5-adde-4eb6fb0157fa/J14EegK9lZ.json',
              //       ),
              //       Lottie.network(
              //         'https://lottie.host/ba6f839c-421a-4677-91ed-7a0b5bec8967/hlf9Ssctm3.json',
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(Icons.check, size: 100, color: Colors.white),
              ),
              SizedBox(height: 50),
              Text(
                'Quiz Completed!',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Your Score is $score out of $totalQuestions',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              Text(
                '${(score / totalQuestions * 100).toStringAsFixed(2)}%',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return NavbarCategoryPage(initialIndex: 0);
                            },
                          ),
                          (route) {
                            return false;
                          },
                        );
                      },
                      buttonText: 'Start new Quiz',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MyButton(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return NavbarCategoryPage(initialIndex: 1);
                            },
                          ),
                          (route) {
                            return false;
                          },
                        );
                      },
                      buttonText: 'Your Ranking',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
