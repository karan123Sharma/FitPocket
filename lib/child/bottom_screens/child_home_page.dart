import 'dart:async';
import 'dart:math';
import 'package:background_sms/background_sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';
import 'package:Fitpocket/child/model/model.dart';
import 'package:Fitpocket/db/db_services.dart';
import 'package:Fitpocket/model/contactsm.dart';
import 'package:Fitpocket/new/screens/start_workout/widget/start_workout_content.dart';
import 'package:Fitpocket/widgets/home_widgets/CustomCarouel.dart';
import 'package:Fitpocket/widgets/home_widgets/custom_appBar.dart';
import 'package:Fitpocket/widgets/home_widgets/emergency.dart';
import 'package:Fitpocket/widgets/home_widgets/safehome/SafeHome.dart';
import 'package:Fitpocket/widgets/live_safe.dart';

import '../../Videos/page/home_page.dart';
import '../../new/core/const/color_constants.dart';
import '../../new/core/const/data_constants.dart';
import '../../new/core/const/text_constants.dart';
import '../../new/screens/home/widget/home_exercises_card.dart';
import '../../new/screens/workout_details_screen/page/workout_details_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({super.key});
  bool condition = false;
  int _countdown = 10;
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
    startTimer();
    showDialog(context: context, builder: (context){
      return CupertinoAlertDialog(
        title: Text('Alert'),
        content: Text('Please Click in.. $_countdown'),
        actions: [
          MaterialButton(onPressed: (){
            condition = false;
            Navigator.pop(context);
          },
          child: Text("Yes"),),
          MaterialButton(onPressed: (){
            condition = true;
            getAndSendSms();
            _countdown = 10;
            Navigator.pop(context);
          },
            child: Text("No"),),
        ],
      );
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
            _countdown = 10;
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
  void startTimer() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _countdown--;
        if (_countdown == 0 && condition == false) {
          getAndSendSms();
          timer.cancel();
          _countdown = 10;
          Navigator.of(context).pop();
        }
        // }
        // else if()

      });
    });
  }
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
        Dig();
        // _countdown = 10;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomCarouel(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    _createExercisesList(context),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Explore Nature...",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 15),
                    LiveSafe(),
                    const SizedBox(height: 15),
                    Gym(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
