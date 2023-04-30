import 'package:flutter/material.dart';
import 'package:Fitpocket/Videos/page/home_page.dart';
import 'package:Fitpocket/child/bottom_screens/add_contacts.dart';
import 'package:Fitpocket/child/bottom_screens/chat_page.dart';
import 'package:Fitpocket/child/bottom_screens/child_home_page.dart';
import 'package:Fitpocket/child/bottom_screens/profile_page.dart';
import 'package:Fitpocket/child/bottom_screens/review_page.dart';

import '../new/screens/workouts/page/workouts_page.dart';

class BottomPage extends StatefulWidget {
  BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    AddContactsPage(),
    HomePage1(),
    ChatPage(),
    ProfilePage(),
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
        items: [
          BottomNavigationBarItem(
              label: 'home',
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              label: 'contacts',
              icon: Icon(
                Icons.contacts,
              )),
          BottomNavigationBarItem(
              label: 'Workouts',
              icon: Icon(
                Icons.sports_gymnastics,
              )),
          BottomNavigationBarItem(
              label: 'Chat',
              icon: Icon(
                Icons.chat,
              )),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                Icons.person,
              ))
        ],
      ),
    );
  }
}
