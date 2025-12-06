import 'package:flutter/material.dart';
import 'package:quiz_application/views/leaderboard_page.dart';
import 'package:quiz_application/views/profile_page.dart';
import 'package:quiz_application/views/quiz_category.dart';

class NavbarCategoryPage extends StatefulWidget {
  final int initialIndex;
  const NavbarCategoryPage({super.key, required this.initialIndex});

  @override
  State<NavbarCategoryPage> createState() => _NavbarCategoryPageState();
}

class _NavbarCategoryPageState extends State<NavbarCategoryPage> {
  List pages = [QuizCategory(), LeaderboardPage(), ProfilePage()];
  int selectPage = 1;
  final PageStorageBucket bucket = PageStorageBucket();
  @override
  void initState() {
    selectPage = widget.initialIndex;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 114, 114, 114),
        iconSize: 30,
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        currentIndex: selectPage,
        onTap: (value) {
          setState(() {
            selectPage = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: PageStorage(bucket: bucket, child: pages[selectPage]),
    );
  }
}
