import 'dart:ui';
import 'package:flutter/material.dart';

class Category {


  String name;
  String Icon;
  Color color;
  String Imgname;
  List<Category> subCategories;

  Category(
  {
    required this.name,
  required this.Icon,
  required this.color,
  required this.Imgname,
  required this.subCategories,
  }
      );


}
