import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/child/bottom_screens/child_home_page.dart';
import '../Videos/page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoApp(),
      theme: ThemeData.dark(),
    );
  }
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  CountDownController _controller = CountDownController();
  bool _isPause = false;
  late Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  Widget simpleDialogBox(){
    return Dialog(
      child: Padding(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            height: 280,
            child: Column(
              children: [
                Text("Exit App"),
                Icon(Icons.exit_to_app,size: 200,),
                Row(
                  children: [
                    TextButton(onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage1()));
                    }, child: Text("Yes")),
                    Spacer(),
                    MaterialButton(
                      onPressed: () {
                        startTimer();
                      },
                      child: Text("start"),
                    ),
                    Text("$_start")
                  ],
                )
              ],
            ),
          )
      ),
      backgroundColor: Colors.orange,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      alignment: Alignment.bottomCenter,
    );

  }
  Widget simpleAlertDialog(){
    return AlertDialog(
      title: const Text("Continue ?",textAlign: TextAlign.center,),
      icon: Icon(Icons.done,size: 50,),
      content: const Text("Are you sure you want to continue ?",textAlign: TextAlign.center,),
      actions: [
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>  HomePage1()));
        }, child: Text("Yes")),
        MaterialButton(
          onPressed: () {
            startTimer();
          },
          child: Text(""),
        ),
        Text("$_start")
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      alignment: AlignmentDirectional.topStart,
    );
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
          duration: 2,
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
                  return simpleAlertDialog();
                });
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












