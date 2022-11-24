import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitpocket/login_screen.dart';
import 'package:fitpocket/pages/home/home.dart';
import 'package:fitpocket/screen/welcom_view.dart';
import 'package:flutter/material.dart';

class check extends StatefulWidget {
  const check({Key? key}) : super(key: key);

  @override
  State<check> createState() => _checkState();
}

class _checkState extends State<check> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
        if(snapshot.hasData){
          return WelcomView();
        }
        else{
          return LoginScreen();
        }
        },),

    );
  }
}
