import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
class Fab extends StatefulWidget {
  const Fab({Key? key}) : super(key: key);

  @override
  State<Fab> createState() => _FabState();
}

class _FabState extends State<Fab> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      key: fabKey,
      // Cannot be `Alignment.center`
      alignment: Alignment.bottomRight,
      ringColor: primaryColor.withOpacity(0.6),
      ringDiameter: 500.0,
      ringWidth: 150.0,
      fabSize: 64.0,
      fabElevation: 8.0,
      fabIconBorder: const CircleBorder(),

      fabColor: Colors.white,
      fabOpenIcon: const Icon(Icons.menu, color: primaryColor),
      fabCloseIcon: const Icon(Icons.close, color: primaryColor),
      fabMargin: const EdgeInsets.all(16.0),
      animationDuration: const Duration(milliseconds: 800),
      animationCurve: Curves.easeInOutCirc,
      onDisplayChange: (isOpen) {
        // _showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
      },
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            _showSnackBar(context, "You pressed 1");
          },
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: const Icon(Icons.looks_one, color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () {
            _showSnackBar(context, "You pressed 2");
          },
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: const Icon(Icons.looks_two, color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () {
            _showSnackBar(context, "You pressed 3");
          },
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: const Icon(Icons.looks_3, color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () {
            _showSnackBar(
                context, "You pressed 4. This one closes the menu on tap");
            fabKey.currentState!.close();
          },
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: const Icon(Icons.looks_4, color: Colors.white),
        )
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message), duration: const Duration(milliseconds: 100)));
  }
}
