import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_dialog_box.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';

import '../../../../../core/constants.dart';
import '../../../../../models/Student.dart';

class StudentCard extends StatelessWidget {
  Student student;
  StudentCard({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return CustomDialogBox(widget: const StudentCardDetails());
              });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: textFieldFillColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600',
                ),
                radius: 35,
              ),
              const SizedBox(
                height: 5,
              ),
              FittedBox(
                child: Text(student.studentName.trim().split(' ')[0],
                    style: const TextStyle(
                        color: primaryColor,
                        fontFamily: 'Poppins',
                        fontSize: 14)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StudentCardDetails extends StatefulWidget {
  const StudentCardDetails({Key? key}) : super(key: key);

  @override
  State<StudentCardDetails> createState() => _StudentCardDetailsState();
}

class _StudentCardDetailsState extends State<StudentCardDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomTextButton(onPressed: () {}, text: 'Remove from this class'),
          CustomTextButton(
              onPressed: () {}, text: 'Assign to a different class'),
          CustomTextButton(onPressed: () {}, text: 'View in student management')
        ],
      ),
    );
  }
}
