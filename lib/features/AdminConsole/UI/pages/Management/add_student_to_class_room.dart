import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/core/cubit/search_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/models/ClassRoom.dart';

import '../../../../../injection_container.dart';
import '../../../../../models/Student.dart';
import '../../../../TeacherConsole/widgets/future_image.dart';
import '../../../Backend/aws_api_client.dart';
import '../../widgets/custom_dialog_box.dart';
import 'common_search.dart';

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // ScreenUtil.init(context, designSize: Size(width, height));
    final managementCubit = BlocProvider.of<ManagementCubit>(context);
    final searchCubit = BlocProvider.of<SearchCubit>(context);
    return Container(
      color: backgroundColor,
      // width: w * 0.5,
      child: Column(
        children: [
          SizedBox(
            height: 80.h,
          ),

          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 10),
          //   child: CustomTextField(
          //     textEditingController: textEditingController,
          //     hintText: 'Search',
          //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          //     width: 300,
          //     prefixIcon: const Icon(
          //       Icons.search,
          //       size: 14,
          //     ),
          //   ),
          // ),

          Expanded(
            child: DottedBorder(
                dashPattern: const [4, 4],
                strokeWidth: 1,
                radius: const Radius.circular(20),
                color: primaryColor,
                child: Container(
                  // height: 420,
                  margin: EdgeInsets.all(30.sp),
                  // padding: const EdgeInsets.all(20),
                  width: 340.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: addList.isEmpty
                      ? Center(
                          child: Text(
                          'Add Students',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                          ),
                        ))
                      : GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: List.generate(
                              addList.length,
                              (index) => Stack(
                                    children: [
                                      Column(
                                        children: [
                                          FutureImage(
                                              imageKey:
                                                  addList[index].profilePhoto),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          FittedBox(
                                            child: Text(
                                              addList[index].studentName,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              addList.removeAt(index);
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.close,
                                              size: 18.sp,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                        ),
                )),
          ),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              bottom: 5.h,
            ),
            child: Center(
              child: CustomTextButton(
                onPressed: () async {
                  var student = await showDialog<Student>(
                      context: context,
                      builder: (_) {
                        return BlocProvider(
                          create: (_) => SearchCubit(
                              apiClient: getIt<AWSApiClient>(),
                              searchMode: SearchMode.Student),
                          child: CustomDialogBox(
                              widget: CommonSearch(
                            searchMode: SearchMode.Student,
                          )),
                        );
                      });
                  // if (student != null) {
                  //   textEditingController.clear();
                  //   textEditingController.text = student.studentName;
                  //   searchCubit.searchAttendance(
                  //       searchQuery: student.studentName,
                  //       mode: attendanceSearchMode);
                  // }

                  if (student != null) {
                    setState(() {
                      addList.add(student);
                    });
                  }
                },
                text: 'Search',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 15.w, right: 15.w, top: 10.h, bottom: 50.h),
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
