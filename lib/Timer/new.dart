// import 'package:flutter/material.dart';
// import 'dart:async';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   StreamController<int> _events;
//
//   @override
//   initState() {
//     super.initState();
//     _events = new StreamController<int>();
//     _events.add(60);
//   }
//
//
//   void alertD(BuildContext ctx) {
//     var alert = AlertDialog(
//       // title: Center(child:Text('Enter Code')),
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20.0))),
//         backgroundColor: Colors.grey[100],
//         elevation: 0.0,
//         content: StreamBuilder<int>(
//             stream: _events.stream,
//             builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//               print(snapshot.data.toString());
//               return Container(
//                 height: 215,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Padding(
//                         padding: const EdgeInsets.only(
//                             top: 10, left: 10, right: 10, bottom: 15),
//                         child: Text(
//                           'Enter Code',
//                           style: TextStyle(
//                               color: Colors.green[800],
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16),
//                         )),
//                     Container(
//                       height: 70,
//                       width: 180,
//                       child: TextFormField(
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center,
//                         decoration: InputDecoration(
//                           enabledBorder: OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.green, width: 0.0)),
//                         ),
//                         keyboardType: TextInputType.number,
//                         maxLength: 10,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 1,
//                     ),
//                     Text('00:${snapshot.data.toString()}'),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(25),
//                           child: Material(
//                             child: InkWell(
//                               onTap: () {
//                                 //Navigator.of(ctx).pushNamed(SignUpScreenSecond.routeName);
//                               },
//                               child: Container(
//                                 width: 100,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(25),
//                                   gradient: LinearGradient(
//                                       colors: [
//                                         Colors.green,
//                                         Colors.grey,
//                                       ],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight),
//                                 ),
//                                 child: Center(
//                                     child: Text(
//                                       'Validate',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     )),
//                               ),
//                             ),
//                           ),
//                         ),
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(25),
//                           child: Material(
//                             child: InkWell(
//                               onTap: () {},
//                               child: Container(
//                                 width: 100,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(25),
//                                   gradient: LinearGradient(
//                                       colors: [
//                                         Colors.grey,
//                                         Colors.green,
//                                       ],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight),
//                                 ),
//                                 child: Center(
//                                     child: Text(
//                                       'Resend',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     )),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ), //new column child
//                   ],
//                 ),
//               );
//             }));
//     showDialog(
//         context: ctx,
//         builder: (BuildContext c) {
//           return alert;
//         });
//   }
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             RaisedButton(
//                 onPressed: () {
//                   _startTimer();
//                   alertD(context);
//                 },
//                 child: Text('Click')),
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }