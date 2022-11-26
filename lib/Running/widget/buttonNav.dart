import 'package:flutter/material.dart';
import 'package:fitpocket/Running/widget/iconColumn.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class buttonNav extends StatelessWidget {
  const buttonNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Color(0xff224A88),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          iconColumn(
              Icon(
                MdiIcons.home,
                color: Colors.orange,
                size: 40,
              ),
              "Home"),
          iconColumn(
               Icon(
                  MdiIcons.dumbbell,
                color: Colors.orange,
                size: 40,
              ),
              "Report"),
          iconColumn(
               Icon(
                MdiIcons.headCheck,
                color: Colors.orange,
                size: 40,
              ),
              "Health"),
          iconColumn(
               Icon(
                  MdiIcons.settingsHelper,
                color: Colors.orange,
                size: 40,
              ),
              "More")
        ],
      ),
    );
  }
}
