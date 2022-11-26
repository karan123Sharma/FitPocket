// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:fitpocket/Running/dahboard.dart';
import 'package:fitpocket/Trainers/chat.dart';
import 'package:fitpocket/Trainers/user_model.dart';
import 'package:fitpocket/Videos/page/exercise_page.dart';
import 'package:fitpocket/Videos/page/home_page.dart';
import 'package:fitpocket/mainpage.dart';
import 'package:fitpocket/pages/details/details.dart';
import 'package:fitpocket/pages/home/home.dart';
import 'package:fitpocket/screen/edit%20Profile.dart';
import 'package:fitpocket/screen/home_view.dart';
import 'package:fitpocket/screen/onboarding/home_page.dart';
import 'package:fitpocket/screen/onboarding/onboarding_page.dart';
import 'package:fitpocket/screen/onboarding/screen_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitpocket/Trainers/Trainer_List.dart';
import 'constants/Yoga2.dart';
import 'constants/Yoga3.dart';
import 'constants/Yoga4.dart';
import 'constants/utils.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitPocket',
      theme: ThemeData(
        fontFamily: 'SFPro',
        textTheme: TextTheme(headline1: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.bold,

        ))
      ),
      routes: {
        '/':(context) =>OnBoardingPage(),
        '/details':(context)=>Details(),
        '/home':(context)=>HomeView(),
        '/CHECK':(context)=>check(),
        '/editProfile':(context)=>SettingsUI(),
        '/Yoga':(context)=>Yoga_Page(),
        '/Yoga2':(context)=>Yoga_Page2(),
        '/Yoga3':(context)=>Yoga_Page3(),
        '/Yoga4':(context)=>Yoga_Page4(),
        '/Chat':(context)=>HomeScreen(),
        '/StepCounter':(context)=>dashboard(),
        '/Exercise':(context) =>HomePage1(),

    },
     initialRoute: '/',
    );
  }
}
//
// class SpashPage extends StatelessWidget {
//   const SpashPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Welcome to Flutter',
//       home: Scaffold(
//         body:
//         Center(
//           child: Container(
//             color: Colors.black,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Align(
//                     alignment: Alignment.center,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => OpeningPage1()
//                             )
//                         );
//                       },
//                       child: Image.asset('assets/Goodlogoremovebgpreview1.png'),
//                     )
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
//
