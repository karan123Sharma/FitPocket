
import 'package:flutter/material.dart';
import 'gym_category.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        GymCategory(imageUrl: 'assets/gym1.png', title: 'CrossFit', color: Colors.orange,),
        GymCategory(imageUrl: 'assets/gym2.png', title: 'Fitness', color: Colors.orange,),
        GymCategory(imageUrl: 'assets/gym3.png', title: 'Gymnastics', color: Colors.orange,),
        GymCategory(imageUrl: 'assets/gym4.png', title: 'Aerobics', color: Colors.orange,),
      ],
    );
  }
}
