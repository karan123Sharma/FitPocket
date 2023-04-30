import 'dart:async';
import 'dart:math';

import 'package:background_sms/background_sms.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';
import 'package:Fitpocket/Timer/new.dart';
import 'package:Fitpocket/child/bottom_screens/child_home_page.dart';
import '../Videos/page/home_page.dart';
import '../db/db_services.dart';
import '../model/contactsm.dart';
import '../../new/core/const/color_constants.dart';
import '../../new/core/const/data_constants.dart';
import '../../new/core/const/text_constants.dart';
import '../../new/screens/home/widget/home_exercises_card.dart';
import '../../new/screens/workout_details_screen/page/workout_details_page.dart';

class DemoApp extends StatefulWidget {
  @override
  State<DemoApp> createState() => _DemoApp();
}

class _DemoApp extends State<DemoApp> {

  CountDownController _controller = CountDownController();
  bool _isPause = false;
  bool condition = false;
  int qIndex = 0;
  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;
  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: 1);
    if (result == SmsStatus.sent) {
      print("Sent");
      Fluttertoast.showToast(msg: "send");
    } else {
      Fluttertoast.showToast(msg: "failed");
    }
  }
  int _countdown = 10;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Widget _createExercisesList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            TextConstants.discoverWorkouts,
            style: TextStyle(
              color: ColorConstants.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 20),
              WorkoutCard(
                  color: ColorConstants.cardioColor,
                  workout: DataConstants.homeWorkouts[0],
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => WorkoutDetailsPage(
                        workout: DataConstants.workouts[0],
                      )))),
              const SizedBox(width: 15),
              WorkoutCard(
                  color: ColorConstants.armsColor,
                  workout: DataConstants.homeWorkouts[1],
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => WorkoutDetailsPage(
                        workout: DataConstants.workouts[2],
                      )))),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
  _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _curentPosition = position;
        print(_curentPosition!.latitude);
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }
  Widget Dig(){
    startTimer();
    return AlertDialog(
      title: Text('Do you Wanna Continue?'),
      content: Text('This alert will close in $_countdown seconds.'),
      actions: [
        TextButton(
          onPressed: () {
            condition = false;
            Navigator.of(context).pop();
            getAndSendSms();
          },
          child: Text('No'),
        ),
        TextButton(onPressed: () {
          condition = true;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage1()));
        }, child: Text("Yes")),
        
      ],
    
    );
  }

  
  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _curentPosition!.latitude, _curentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
        "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  getRandomQuote() {
    Random random = Random();
    setState(() {
      qIndex = random.nextInt(6);
    });
  }

  getAndSendSms() async {
    List<TContact> contactList = await DatabaseHelper().getContactList();

    String messageBody =
        "https://maps.google.com/?daddr=${_curentPosition!.latitude},${_curentPosition!.longitude}";
    if (await _isPermissionGranted()) {
      contactList.forEach((element) {
        _sendSms("${element.number}", "i am in trouble $messageBody");
      });
    } else {
      Fluttertoast.showToast(msg: "something wrong");
    }
  }
  void _showDialog(bool num){

    showDialog(context: context, builder: (context){
      return CupertinoAlertDialog(
        title: Text('Alert'),
        content: Text('Please Click....'),
        actions: [
          MaterialButton(onPressed: (){
            num = true;
            Navigator.pop(context);
          },
            child: Text("Yes"),),
          MaterialButton(onPressed: (){
            num = false;
            Navigator.pop(context);
            getAndSendSms();
          },
            child: Text("No"),),
        ],
      );
    });
  }
  // Widget simpleAlertDialog() {
  //   return AlertDialog(
  //     title: const Text("Continue ?", textAlign: TextAlign.center,),
  //     icon: Icon(Icons.done, size: 50,),
  //     content: const Text(
  //       "Are you sure you want to continue ?", textAlign: TextAlign.center,),
  //     actions: [
  //       TextButton(onPressed: () {
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => HomePage1()));
  //       }, child: Text("Yes")),
  //       TextButton(onPressed: () {
  //         Navigator.pop(context,MaterialPageRoute(builder: (context)=> HomeScreen()));
  //         getAndSendSms();
  //       }, child: Text("No")),
  //     ],
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(16))
  //     ),
  //     alignment: AlignmentDirectional.topStart,
  //   );
  // }

  @override
  void initState() {
    getRandomQuote();
    super.initState();
    _getPermission();
    _getCurrentLocation();
    ////// shake feature ///
    ShakeDetector.autoStart(
      onPhoneShake: () {
        bool num = true;
        _showDialog(num);
        if(num == false){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something Bad Happened'),
            ),
          );
        }
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }
  void startTimer() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _countdown--;
        if (_countdown == 0 && condition == false) {
          getAndSendSms();
          timer.cancel();
          Navigator.of(context).pop();
        }
        // }
        // else if()

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer'),
        centerTitle: true,
      ),
      body: Center(
        child: CircularCountDownTimer(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          duration: 3,
          fillColor: Colors.amber,
          controller: _controller,
          backgroundColor: Colors.white54,
          strokeWidth: 10.0,
          strokeCap: StrokeCap.round,
          isTimerTextShown: true,
          isReverse: false,
          onComplete: (){
            showDialog(context: context,
                builder: (context){
                  return Dig();
                },);
          },
          textStyle: TextStyle(fontSize: 50.0,color: Colors.black), ringColor: Colors.white,
        ),
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          setState(() {
            if(_isPause){
              _isPause = false;
              _controller.resume();
            }else{
              _isPause = true;
              _controller.pause();
            }
          });
        },
        icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
        label: Text(_isPause ? 'Resume' : 'Pause'),
      ),
    );
  }
}












