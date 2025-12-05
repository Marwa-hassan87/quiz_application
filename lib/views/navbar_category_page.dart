import 'package:flutter/material.dart';
import 'package:quiz_application/views/profile_page.dart';
import 'package:quiz_application/views/quiz_category.dart';

class NavbarCategoryPage extends StatefulWidget {
  final int initialIndex;
  const NavbarCategoryPage({super.key, required this.initialIndex});

  @override
  State<NavbarCategoryPage> createState() => _NavbarCategoryPageState();
}

class _NavbarCategoryPageState extends State<NavbarCategoryPage> {
  List pages = [
    QuizCategory(),
    Scaffold(body: Center(child: Text('Leaderboard'))),
    ProfilePage(),
  ];
  int selectPage = 0;
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
        unselectedItemColor: Colors.grey,
        iconSize: 30,
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
