import 'package:flutter/material.dart';
import '../model/work_out.dart';
import 'detail_view.dart';

class Gym extends StatefulWidget {
  const Gym({Key? key}) : super(key: key);

  @override
  State<Gym> createState() => _GymState();
}
// final screens =[
//   HomePage(),
//   NextPage(),
//   FavouritePage(),
//   ProfilePage(),
// ];

class _GymState extends State<Gym> {
  @override
  Widget build(BuildContext context) {
    List<WorkOut> _workOutList = WorkOut.getWorkOutList();
    return Container(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _workOutList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailView(id: index)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Stack(
                            children: [
                              Hero(
                                tag: _workOutList[index].imageUrl,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child:
                                      Image.asset(_workOutList[index].imageUrl),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 20,
                                child: _workOutList[index].isTopRated
                                    ? Image.asset(
                                        "assets/medal.png",
                                        height: 50,
                                      )
                                    : const Text(''),
                              ),
                              Positioned(
                                top: 10,
                                left: 20,
                                child: Text(
                                  _workOutList[index].time.toString() + "hours",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 30,
                                left: 20,
                                child: Text(
                                  _workOutList[index].exercises.toString() +
                                      "exercises",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 50,
                                left: 20,
                                child: Text(
                                  r"$" + _workOutList[index].cost.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 50,
                                left: 20,
                                child: Text(
                                  _workOutList[index].title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
  }
}
