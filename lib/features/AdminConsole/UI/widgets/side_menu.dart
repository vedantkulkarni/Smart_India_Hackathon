import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/core/constants.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: sideMenubg,
      child: Column(
        children: const [
          ListTile(
            title: Text("Side Menu"),
          )
        ],
      ),
    );
  }
}
