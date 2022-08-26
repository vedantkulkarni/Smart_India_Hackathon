import 'package:fluent_ui/fluent_ui.dart' as fi;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/compare_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/compare_gender_wise.dart';
import '../../../../core/constants.dart';
import '../../../../models/ClassRoom.dart';
import '../widgets/custom_textbutton.dart';

class CompareConsole extends StatefulWidget {
  const CompareConsole({Key? key}) : super(key: key);

  @override
  State<CompareConsole> createState() => _CompareConsoleState();
}

class _CompareConsoleState extends State<CompareConsole> {
  final fi.TextEditingController _compareSearchTextController =
      fi.TextEditingController();
  String hintText = 'Search'.tr;
  bool showCalender = true;

  List<ClassRoom> classRooms = [];
  ClassRoom? selectedClassRoom;
  List<ClassRoom> selectedClassRoomsList = [];

  @override
  Widget build(BuildContext context) {
    final compareCubit = BlocProvider.of<CompareCubit>(context);
    return BlocBuilder<CompareCubit, CompareState>(
      builder: (context, state) {
        if (state is CompareInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final classesList = compareCubit.classRoomList;
        // selectedClassRoom = classesList[0];
        return Container(
          color: backgroundColor,
          child: Column(
            children: [
              SizedBox(
                width: 20.w,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  const Text('Select Classes to compare'),
                  SizedBox(
                    width: 20.w,
                  ),
                  DropdownButton<ClassRoom>(
                    icon: null,
                    iconSize: 14.sp,
                    alignment: Alignment.center,
                    underline: Container(),
                    borderRadius: BorderRadius.circular(10),
                    value: selectedClassRoom ?? classesList[0],
                    onChanged: (value) async {
                      // managementCubit.getAllUsers(role: value);
                      if (value != null) {
                        print(value.classRoomName);
                        setState(() {
                          selectedClassRoom = value;
                        });
                      }
                    },
                    items: List.generate(
                        classesList.length,
                        (index) => DropdownMenuItem(
                            child: fi.Text(classesList[index].classRoomName),
                            value: classesList[index])),
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  const Spacer(),
                  SizedBox(
                      height: 45.h,
                      width: 150.w,
                      child: TextButton(
                          onPressed: () {
                            if (selectedClassRoom == null) {
                              return;
                            }
                            selectedClassRoomsList.add(selectedClassRoom!);
                            selectedClassRoom = classesList[0];
                            setState(() {});
                          },
                          child: fi.Row(
                            mainAxisAlignment: fi.MainAxisAlignment.center,
                            children: [
                              Text('Add',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'Poppins',
                                      fontSize: 12.sp)),
                              Icon(
                                Icons.add,
                                size: 18.sp,
                                color: primaryColor,
                              )
                            ],
                          ))),
                  SizedBox(
                    width: 20.w,
                  ),
                  SizedBox(
                    width: 20.w,
                  )
                ],
              ),
              fi.Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: fi.EdgeInsets.all(10.sp),
                      height: 40.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: List.generate(
                            selectedClassRoomsList.length,
                            (index) => fi.Container(
                                  margin:
                                      fi.EdgeInsets.symmetric(horizontal: 5.w),
                                  width: 150.w,
                                  height: 30.h,
                                  child: CustomTextButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        // searchQuery.removeAt(index);
                                        // setState(() {});
                                      },
                                      text: selectedClassRoomsList[index]
                                          .classRoomName),
                                )),
                      ),
                    ),
                  ),
                  fi.SizedBox(
                    width: 30.w,
                  )
                ],
              ),
              fi.SizedBox(
                width: 30.w,
              ),
              selectedClassRoomsList.isEmpty
                  ? fi.Container(
                      child: const fi.Center(
                          child:
                              fi.Text('Please select classrooms to compare')),
                    )
                  : fi.Row(
                      children: [
                        CompareGenderWise(selectedList: selectedClassRoomsList),
                      ],
                    )
            ],
          ),
        );
      },
    );
  }
}

class CompareQuery {
  List<ClassRoom> compareList;
  ClassRoomCompareMode mode;
  CompareQuery({required this.compareList, required this.mode});
}
