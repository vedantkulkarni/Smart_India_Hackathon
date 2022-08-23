import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/student_search.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textfield.dart';

import '../../../../../core/cubit/search_cubit.dart';

class CommonSearch extends StatefulWidget {
  SearchMode searchMode;
  CommonSearch({Key? key, required this.searchMode}) : super(key: key);

  @override
  State<CommonSearch> createState() => _CommonSearchState();
}

class _CommonSearchState extends State<CommonSearch> {
  final TextEditingController textEditingController = TextEditingController();
  var searchMode = StudentSearchMode.name;
  @override
  Widget build(BuildContext context) {
    final searchCubit = BlocProvider.of<SearchCubit>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                      textEditingController: textEditingController,
                      hintText: 'Search Name, Roll Number or Email Id',
                      padding: const EdgeInsets.all(10)),
                ),
                 SizedBox(
                  width: 20.w,
                ),
                DropdownButton<StudentSearchMode>(
                  icon: null,
                  iconSize: 14,
                  alignment: Alignment.center,
                  underline: Container(),
                  borderRadius: BorderRadius.circular(10),
                  value: searchMode,
                  onChanged: (value) {
                    // managementCubit.clearUserList();
                    setState(() {
                      searchMode = value!;
                    });
                    // managementCubit.getAllUsers(role: value);
                  },
                  items:  [
                    DropdownMenuItem(
                      child: Text('Name',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14.sp)),
                      value: StudentSearchMode.name,
                    ),
                    DropdownMenuItem(
                        child: Text('Email',
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Poppins',
                                fontSize: 14.sp)),
                        value: StudentSearchMode.email),
                    DropdownMenuItem(
                        child: Text('Roll Number',
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Poppins',
                                fontSize: 14.sp)),
                        value: StudentSearchMode.roll),
                  ],
                ),
                 SizedBox(
                  width: 40.w,
                ),
                SizedBox(
                    width: 120.w,
                    child: CustomTextButton(
                        onPressed: () {
                          searchCubit.searchStudent(
                              searchQuery: textEditingController.text,
                              mode: searchMode);
                        },
                        text: 'Search'))
              ],
            ),
             SizedBox(
              height: 20.h,
            ),
            Container(
                child: widget.searchMode == SearchMode.Student
                    ? const StudentSearch()
                    : const StudentSearch())
          ],
        ),
      ),
    );
  }
}
