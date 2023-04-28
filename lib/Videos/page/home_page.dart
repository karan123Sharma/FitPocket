import 'package:flutter/material.dart';

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
        expandedHeight: MediaQuery.of(context).size.height * 0.5,
        stretch: true,
        title: Text('Statistics'),
        centerTitle: true,
        pinned: true,
        leading: Icon(Icons.menu),
        actions: [
          Icon(Icons.person, size: 28),
          SizedBox(width: 12),
        ],
      );
}
