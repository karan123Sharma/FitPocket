import 'package:flutter/material.dart';
import 'package:Fitpocket/child/bottom_screens/child_home_page.dart';

import '../widget/exercises_widget.dart';

class HomePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(

          physics: BouncingScrollPhysics(),
          slivers: [
            buildAppBar(context),
            ExercisesWidget(),
          ],
        ),
      );
  SliverAppBar buildAppBar(BuildContext context) => SliverAppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Statistics'),
        centerTitle: true,
        pinned: true,
        leading: Icon(Icons.menu),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child:Icon(Icons.person, size: 28),
          ),
          SizedBox(width: 12),

        ],
      );
}
