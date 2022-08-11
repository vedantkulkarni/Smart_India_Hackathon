import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/models/ClassRoom.dart';

import '../../../../../models/Student.dart';
import '../../widgets/custom_textfield.dart';

class AddStudentToClassRoom extends StatefulWidget {
  ClassRoom classRoom;
  AddStudentToClassRoom({Key? key, required this.classRoom}) : super(key: key);

  @override
  State<AddStudentToClassRoom> createState() => _AddStudentToClassRoomState();
}

class _AddStudentToClassRoomState extends State<AddStudentToClassRoom> {
  List<Student> addList = [];
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    final managementCubit = BlocProvider.of<ManagementCubit>(context);
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: CustomTextField(
              textEditingController: textEditingController,
              hintText: 'Search',
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: 300,
              prefixIcon: const Icon(
                Icons.search,
                size: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          addList.isEmpty
              ? Expanded(
                  child: DottedBorder(
                      dashPattern: const [4, 4],
                      strokeWidth: 1,
                      radius: const Radius.circular(20),
                      color: lightTextColor,
                      child: Container(
                        // height: 420,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                            child: Text(
                          'Add Students',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                          ),
                        )),
                        //color: Colors.red,
                      )),
                )
              : Row(
                  children: List.generate(
                      addList.length,
                      (index) => const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600'),
                          )),
                ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 5,
            ),
            child: Center(
              child: CustomTextButton(
                onPressed: () async {
                  final searchedStudent = await managementCubit.getStudent(
                      studentID: textEditingController.text);
                  setState(() {
                    addList.add(searchedStudent);
                  });
                },
                text: 'Search',
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 50),
            child: Center(
              child: CustomTextButton(
                onPressed: () async {
                  await managementCubit.bulkUpdateStudents(
                      bulkList: addList, classRoomID: widget.classRoom.id);
                  Navigator.pop(context, true);
                },
                text: 'Add',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
