import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:fluent_ui/fluent_ui.dart' as fi;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_dialog_box.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/select_date_dialog.dart';

import '../../../../core/cubit/search_cubit.dart';
import '../../../../injection_container.dart';
import '../../../../models/Student.dart';
import '../../Backend/aws_api_client.dart';
import '../widgets/attendance_search.dart';
import '../widgets/custom_textfield.dart';
import 'Management/common_search.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool show = true;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      child: Row(children: [
        const Expanded(child: AttendanceWidget()),
        const VerticalDivider(
          width: 1,
          color: greyColor,
          thickness: 1,
        ),
        Container(
            width: w * 0.3,
            color: navPanecolor,
            padding: const EdgeInsets.all(10),
            child: Container(
              child: const Center(
                child: Text('Detials'),
              ),
            )),
      ]),
    );
  }
}

class AttendanceWidget extends StatefulWidget {
  const AttendanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {
  final TextEditingController textEditingController = TextEditingController();

  AttendanceSearchMode attendanceSearchMode = AttendanceSearchMode.date;
  bool showCalender = true;
  String hintText = 'YYYY-MM-DD';
  @override
  Widget build(BuildContext context) {
    final searchCubit = BlocProvider.of<SearchCubit>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // ScreenUtil.init(context, designSize: Size(width, height));
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          SizedBox(
            width: 20.w,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: CustomTextField(
                    textEditingController: textEditingController,
                    hintText: hintText,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                    prefixIcon: const Icon(
                      fi.FluentIcons.search,
                      size: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              showCalender == false
                  ? Container()
                  : IconButton(
                      icon: const Icon(
                        fi.FluentIcons.calendar,
                        size: 22,
                        color: primaryColor,
                      ),
                      onPressed: () async {
                        var value = await showDialog<DateTime>(
                          context: context,
                          builder: (context) {
                            return CustomDialogBox(
                                widget: const SelectDateDialog());
                          },
                        );
                        if (value != null) {
                          textEditingController.text =
                              TemporalDate(value).toString();
                        }
                      },
                    ),
              DropdownButton<AttendanceSearchMode>(
                icon: null,
                iconSize: 14,
                alignment: Alignment.center,
                underline: Container(),
                borderRadius: BorderRadius.circular(10),
                value: attendanceSearchMode,
                onChanged: (value) async {
                  // managementCubit.clearUserList();
                  if (value == AttendanceSearchMode.date) {
                    textEditingController.clear();
                    hintText = 'YYYY-MM-DD';
                    showCalender = true;
                  } else {
                    textEditingController.clear();
                    showCalender = false;
                    hintText = 'Search by ${value!.name}';
                  }

                  if (value == AttendanceSearchMode.studentID) {
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
                    if (student != null) {
                      textEditingController.clear();
                      textEditingController.text = student.studentName;
                      searchCubit.searchAttendance(
                          searchQuery: student.studentName,
                          mode: attendanceSearchMode);
                    }
                  }

                  setState(() {
                    attendanceSearchMode = value!;
                  });
                  // managementCubit.getAllUsers(role: value);
                },
                items: [
                  DropdownMenuItem(
                    child: Text('Search by Date',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 14.sp)),
                    value: AttendanceSearchMode.date,
                  ),
                  DropdownMenuItem(
                      child: Text('Search by Attendance Status',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14.sp)),
                      value: AttendanceSearchMode.status),
                  DropdownMenuItem(
                      child: Text('Search by Student',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14.sp)),
                      value: AttendanceSearchMode.studentID),
                  DropdownMenuItem(
                      child: Text('Search by Teacher Name',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14.sp)),
                      value: AttendanceSearchMode.teacherName),
                  DropdownMenuItem(
                      child: Text('Search by Teacher Email',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14.sp)),
                      value: AttendanceSearchMode.teacherID),
                ],
              ),
              SizedBox(
                width: 40.w,
              ),
              SizedBox(
                height: 45.h,
                width: 100.w,
                child: CustomTextButton(
                    onPressed: () {
                      searchCubit.searchAttendance(
                          searchQuery: textEditingController.text,
                          mode: attendanceSearchMode);
                    },
                    text: 'Search'),
              ),
              SizedBox(
                width: 20.w,
              )
            ],
          ),
          const Divider(
            color: greyColor,
            thickness: 0.5,
          ),
          const Expanded(
            child: AttendanceSearch(),
          ),
        ],
      ),
    );
  }
}
