import 'package:fitpocket/Widgets/batoomnav.dart';
import 'package:fitpocket/pages/details/Widgets/Dates.dart';
import 'package:fitpocket/pages/details/Widgets/Graphs.dart';
import 'package:fitpocket/pages/details/Widgets/Info.dart';
import 'package:fitpocket/pages/details/Widgets/Stats.dart';
import 'package:fitpocket/pages/details/Widgets/Steps.dart';
import 'package:flutter/material.dart';


class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          dates(),
          Steps(),
          Graphs(),
          Info(),
          Stats(),
          BottomNavigation(),

        ],
      ),
    );
  }
}
