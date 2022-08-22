import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:fluent_ui/fluent_ui.dart' as fi;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_dialog_box.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/select_date_dialog.dart';
import 'package:team_dart_knights_sih/models/AttendanceStatus.dart';

import '../../../../core/cubit/search_cubit.dart';
import '../widgets/attendance_search.dart';
import '../widgets/custom_textfield.dart';

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

  List<SearchQuery> searchQuery = [];
  AttendanceSearchMode currentMode = AttendanceSearchMode.date;
  AttendanceStatus? attendanceStatus;
  bool showCalender = true;
  String hintText = 'YYYY-MM-DD';
  @override
  Widget build(BuildContext context) {
    final searchCubit = BlocProvider.of<SearchCubit>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          const SizedBox(
            width: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: CustomTextField(
                    textEditingController: textEditingController,
                    hintText: hintText,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    prefixIcon: const Icon(
                      fi.FluentIcons.search,
                      size: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
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
                value: currentMode,
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

                  if (value == AttendanceSearchMode.studentName) {
                    // var student = await showDialog<Student>(
                    //     context: context,
                    //     builder: (_) {
                    //       return BlocProvider(
                    //         create: (_) => SearchCubit(
                    //             apiClient: getIt<AWSApiClient>(),
                    //             searchMode: SearchMode.Student),
                    //         child: CustomDialogBox(
                    //             widget: CommonSearch(
                    //           searchMode: SearchMode.Student,
                    //         )),
                    //       );
                    //     });
                    // if (student != null) {
                    //   textEditingController.clear();
                    //   textEditingController.text = student.studentName;
                    searchCubit.searchAttendance(searchQuery: [
                      SearchQuery(
                          mode: currentMode,
                          searchText: textEditingController.text)
                    ]);
                  }

                  setState(() {
                    currentMode = value!;
                  });
                  // managementCubit.getAllUsers(role: value);
                },
                items: const [
                  DropdownMenuItem(
                    child: Text('Search by Date',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 14)),
                    value: AttendanceSearchMode.date,
                  ),
                  DropdownMenuItem(
                      child: Text('Search by Student',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14)),
                      value: AttendanceSearchMode.studentName),
                  DropdownMenuItem(
                      child: Text('Search by Assigned Class',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14)),
                      value: AttendanceSearchMode.className),
                  DropdownMenuItem(
                      child: Text('Search by Teacher Name',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14)),
                      value: AttendanceSearchMode.teacherName),
                  DropdownMenuItem(
                      child: Text('Search by Teacher Email',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14)),
                      value: AttendanceSearchMode.teacherID),
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              SizedBox(
                  height: 45,
                  width: 150,
                  child: TextButton(
                      onPressed: () {
                        if (textEditingController.text.isEmpty) {
                          return;
                        }
                        final myQuery = SearchQuery(
                            mode: currentMode,
                            searchText: textEditingController.text);
                        searchQuery.add(myQuery);
                        setState(() {});
                      },
                      child: fi.Row(
                        mainAxisAlignment: fi.MainAxisAlignment.center,
                        children: const [
                          Text('Add Filter',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 14)),
                          Icon(
                            Icons.add,
                            size: 18,
                            color: primaryColor,
                          )
                        ],
                      ))),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                  height: 45,
                  width: 150,
                  child: CustomTextButton(
                      onPressed: () {
                        if (searchQuery.isEmpty) {
                          return;
                        } else if (attendanceStatus != null) {
                          var newList = [...searchQuery];
                          newList.add(SearchQuery(
                              mode: AttendanceSearchMode.status,
                              searchText: attendanceStatus!.name));
                          searchCubit.searchAttendance(searchQuery: newList);
                        } else {
                          searchQuery.removeWhere(
                            (element) =>
                                element.mode == AttendanceSearchMode.status,
                          );
                          searchCubit.searchAttendance(
                              searchQuery: searchQuery);
                        }
                      },
                      text: 'Search')),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          fi.Row(
            children: [
              Expanded(
                child: Container(
                  margin: const fi.EdgeInsets.all(10),
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: List.generate(
                        searchQuery.length,
                        (index) => fi.Container(
                              margin:
                                  const fi.EdgeInsets.symmetric(horizontal: 5),
                              width: 150,
                              height: 30,
                              child: CustomTextButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    searchQuery.removeAt(index);
                                    setState(() {});
                                  },
                                  text: searchQuery[index].searchText),
                            )),
                  ),
                ),
              ),
              DropdownButton<AttendanceStatus>(
                icon: null,
                iconSize: 14,
                alignment: Alignment.center,
                underline: Container(),
                borderRadius: BorderRadius.circular(10),
                value: attendanceStatus,
                onChanged: (value) async {
                  if (value == null) {
                    attendanceStatus = value;
                    searchQuery.removeWhere(
                      (element) => element.mode == AttendanceSearchMode.status,
                    );
                    setState(() {});
                    searchCubit.searchAttendance(searchQuery: searchQuery);
                    return;
                  }
                  attendanceStatus = value;
                  var newList = [...searchQuery];
                  newList.add(SearchQuery(
                      mode: AttendanceSearchMode.status,
                      searchText: attendanceStatus!.name));
                  setState(() {});
                  searchCubit.searchAttendance(searchQuery: newList);
                  // managementCubit.getAllUsers(role: value);
                },
                items: const [
                  DropdownMenuItem(
                      child: Text("Present",
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14)),
                      value: AttendanceStatus.Present),
                  DropdownMenuItem(
                      child: Text("Absent",
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14)),
                      value: AttendanceStatus.Absent),
                  DropdownMenuItem(
                      child: Text("All",
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14)),
                      value: null),
                ],
              ),
              const fi.SizedBox(
                width: 30,
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

class SearchQuery {
  final String searchText;
  final AttendanceSearchMode mode;
  SearchQuery({required this.mode, required this.searchText});
}
