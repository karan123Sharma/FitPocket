// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:fitpocket/Widgets/batoomnav.dart';
import 'package:fitpocket/pages/home/widgets/activity.dart';
import 'package:fitpocket/pages/home/widgets/current.dart';
import 'package:fitpocket/pages/home/widgets/header.dart';
import 'package:flutter/material.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Column(
        children: [
          Appheader(),
          CurrentPrograms(),
          RecentActivity(),
          BottomNavigation(),
        ],
      ),
    );
  }
}
