import 'package:flutter/material.dart';

import '../../../../../core/constants.dart';

class ManageClassroom extends StatefulWidget {
  const ManageClassroom({Key? key}) : super(key: key);

  @override
  State<ManageClassroom> createState() => _ManageClassroomState();
}

class _ManageClassroomState extends State<ManageClassroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Container()],
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: blackColor),
      ),
      body: Container(
          child: const Center(
        child: Text('ClassRoom Management'),
      )),
    );
  }
}
