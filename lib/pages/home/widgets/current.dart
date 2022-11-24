import 'package:flutter/material.dart';
class CurrentPrograms extends StatefulWidget {
  const CurrentPrograms({Key? key}) : super(key: key);

  @override
  State<CurrentPrograms> createState() => _CurrentProgramsState();
}

class _CurrentProgramsState extends State<CurrentPrograms> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Current Programs ",
              style: Theme.of(context).textTheme.headline1,),
              Icon(Icons.arrow_forward_ios,size: 15,),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 100,

          child: ListView.builder(
            scrollDirection:Axis.horizontal,
              itemBuilder:(context,index){
           return Text("Hello");
          }),

        )
      ],
    );
  }
}
