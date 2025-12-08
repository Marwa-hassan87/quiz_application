import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});
  Stream<List<Map<String, dynamic>>> getLeaderboard() {
    return FirebaseFirestore.instance
        .collection('userData')
        .orderBy('score', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: getLeaderboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data!;
          if (users.isEmpty) {
            return Center(child: Text('No users found'));
          }
          final topThree = users.take(3).toList();
          final remainingUsers = users.skip(3).toList();
          return Container(
            color: Colors.blue,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 40, bottom: 20),
                  height: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: _buildTopUsers(topThree[1], 2)),
                      Expanded(child: _buildTopUsers(topThree[0], 1)),
                      Expanded(child: _buildTopUsers(topThree[2], 3)),
                    ],
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child: ListView.builder(
                        itemCount: remainingUsers.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '${index + 4}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            remainingUsers[index]['photoBase64'] ==
                                                null
                                            ? NetworkImage(
                                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                              )
                                            : MemoryImage(
                                                base64Decode(
                                                  remainingUsers[index]['photoBase64'],
                                                ),
                                              ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        remainingUsers[index]['name'],
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${remainingUsers[index]['score']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildTopUsers(Map<String, dynamic> users, int rank) {
  return Column(
    mainAxisAlignment: rank != 1
        ? MainAxisAlignment.center
        : MainAxisAlignment.start,
    children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: rank != 1
                    ? const Color.fromARGB(255, 9, 51, 85)
                    : Colors.amber,
                width: 5,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: CircleAvatar(
              radius: rank != 1 ? 45 : 55,
              backgroundImage: users['photoBase64'] == null
                  ? NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                    )
                  : MemoryImage(base64Decode(users['photoBase64']))
                        as ImageProvider,
            ),
          ),
          if (rank == 1)
            Positioned(
              left: 0,
              right: 0,
              top: -20,
              child: Icon(
                FontAwesomeIcons.crown,
                size: 30,
                color: Colors.amber,
              ),
            ),
          Positioned(
            bottom: -5,
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: rank != 1
                  ? Color.fromARGB(255, 9, 51, 85)
                  : Colors.amber,
              foregroundColor: Colors.white,
              child: Text('$rank'),
            ),
          ),
        ],
      ),
      SizedBox(height: 5),
      Text(
        users['name'],
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '${users['score']}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ' Points',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
