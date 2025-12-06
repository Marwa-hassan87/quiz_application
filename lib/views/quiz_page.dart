// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_application/views/result_page.dart';
import 'package:quiz_application/widgets/my_button.dart';

class QuizPage extends StatefulWidget {
  final String categoryName;
  const QuizPage({super.key, required this.categoryName});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> question = [];
  int currentIndex = 0, score = 0;
  int? selectedOption;
  bool hasAnswered = false;
  bool isLoading = true;
  @override
  void initState() {
    _fetchQuestions();
    super.initState();
  }

  Future<void> _fetchQuestions() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('QuestionsSet')
          .doc(widget.categoryName)
          .get();
      if (snapshot.exists) {
        var data = snapshot.data();
        if (data != null && data.containsKey('questions')) {
          var questions = data['questions'];
          if (questions is Map<String, dynamic>) {
            var fetchQuestions = questions.entries.map((entry) {
              var q = entry.value;
              var optionsMap = q['options'] as Map<String, dynamic>;
              var optionList = optionsMap.entries.toList()
                ..sort((a, b) => int.parse(a.key).compareTo(int.parse(b.key)));
              var options = optionList
                  .map((entry) => entry.value.toString())
                  .toList();
              return {
                'questionText': q['questionText'] ?? 'No Questions',
                'options': options,
                'correctOptionKey':
                    int.tryParse(q['correctOptionKey'].toString()) ?? 0,
              };
            }).toList();
            fetchQuestions.shuffle(Random());
            setState(() {
              question = fetchQuestions;
            });
          }
        }
      }
    } catch (err) {
      print(err.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _checkAnswer(int index) {
    setState(() {
      hasAnswered = true;
      selectedOption = index;
      if (question[currentIndex]['correctOptionKey'] == index + 1) {
        score++;
      }
    });
  }

  Future<void> _nextQuestion() async {
    if (currentIndex < question.length - 1) {
      setState(() {
        currentIndex++;
        hasAnswered = false;
        selectedOption = null;
      });
    } else {
      await _updateScore();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ResultPage(score: score, totalQuestions: question.length);
          },
        ),
      );
    }
  }

  Future<void> _updateScore() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      var userRef = FirebaseFirestore.instance
          .collection('userData')
          .doc(user.uid);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        var snapshot = await transaction.get(userRef);
        if (!snapshot.exists) return;
        int existingScore = snapshot['score'] ?? 0;
        transaction.update(userRef, {'score': existingScore + score});
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print(question);
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (question.isEmpty) {
      return Scaffold(body: Center(child: Text('No Questions available')));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          '${widget.categoryName} (${currentIndex + 1}/${question.length})',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (currentIndex + 1) / question.length,
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 226, 237, 247),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(123, 175, 175, 175),
                    offset: Offset(0, 3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Text(
                question[currentIndex]['questionText'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 28, 124, 202),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                // itemCount: 4,
                itemBuilder: (context, index) {
                  return _buildOption(index);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: question[currentIndex]['options'].length ?? 0,
              ),
            ),
            if (hasAnswered)
              SizedBox(
                width: double.infinity,
                child: MyButton(
                  onTap: _nextQuestion,
                  buttonText: currentIndex == question.length - 1
                      ? 'Finish'
                      : 'Next',
                ),
              ),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(int index) {
    bool isCorrect = question[currentIndex]['correctOptionKey'] == index + 1;
    bool isSelected = selectedOption == index;
    Color bgColor = hasAnswered
        ? (isCorrect
              ? Colors.green
              : isSelected
              ? Colors.red
              : const Color.fromARGB(255, 233, 233, 233))
        : const Color.fromARGB(255, 233, 233, 233);
    Color textColor = hasAnswered && (isCorrect || isSelected)
        ? Colors.white
        : Colors.black;
    return InkWell(
      onTap: hasAnswered ? null : () => _checkAnswer(index),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(122, 146, 146, 146),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          question[currentIndex]['options'][index],
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor, fontSize: 15),
        ),
      ),
    );
  }
}
