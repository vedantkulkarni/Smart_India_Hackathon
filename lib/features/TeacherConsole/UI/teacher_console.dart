import 'package:flutter/material.dart';

class TeacherConsole extends StatefulWidget {
  TeacherConsole({Key? key}) : super(key: key);

  @override
  State<TeacherConsole> createState() => _TeacherConsoleState();
}

class _TeacherConsoleState extends State<TeacherConsole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Center(child: Text("teacher console"),)),
    );
  }
}