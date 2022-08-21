import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/add_student_to_class_room.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/assign_teacher_to_class_room.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/class_details_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/download_attendance.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/student_card.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_dialog_box.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/models/ClassRoom.dart';

import '../../../../../core/constants.dart';
import '../../../../../models/User.dart';
import 'cubit/management_cubit.dart';
import '../../../../../injection_container.dart';
import '../../../Backend/admin_bloc/admin_cubit.dart';

class ClassRoomDetails extends StatefulWidget {
  final ClassRoom classRoom;
  const ClassRoomDetails({Key? key, required this.classRoom}) : super(key: key);

  @override
  State<ClassRoomDetails> createState() => _ClassRoomDetailsState(classRoom);
}

class _ClassRoomDetailsState extends State<ClassRoomDetails> {
  ClassRoom classRoom;
  _ClassRoomDetailsState(this.classRoom);
  @override
  Widget build(BuildContext context) {
    final classDetailsCubit = BlocProvider.of<ClassDetailsCubit>(context);

    return Scaffold(
        appBar: AppBar(
          actions: [Container()],
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: blackColor),
        ),
        body: BlocBuilder<ClassDetailsCubit, ClassDetailsState>(
          builder: (context, state) {
            if (state is ClassDetailsInitial || state is LoadingClassDetails) {
              return progressIndicator;
            }

            var classDetails = classDetailsCubit.classRoom;
            return Container(
              color: backgroundColor,
              height: double.maxFinite,
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                child: Column(
                  children: [
                    AssignedTeacherWidget(
                      classRoom: classDetails,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                            child: ClassRoomDashBoardWidget(
                          classRoom: classDetails,
                        )),
                        ClassDetailsSideMenu(
                          classRoom: classDetails,
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class AssignedTeacherWidget extends StatelessWidget {
  ClassRoom classRoom;
  AssignedTeacherWidget({Key? key, required this.classRoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final classCubit = BlocProvider.of<ClassDetailsCubit>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10)
        ],
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        Container(
          // height: double.maxFinite,
          // color: primaryColor,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                classRoom.classRoomName,
                style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: blackColor),
              ),
              Row(
                children: [
                  Text(
                    'Students : ',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: lightTextColor),
                  ),
                  Text(
                    classRoom.students == null
                        ? '0'
                        : classRoom.students!.length.toString(),
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: primaryColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'School : ',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: lightTextColor),
                  ),
                  Text(
                    classRoom.schoolID,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
        const VerticalDivider(
          thickness: 1,
          width: 1,
          color: primaryColor,
        ),
        const Spacer(),
        const VerticalDivider(
          color: primaryColor,
        ),
        classRoom.userAssignedClassId == null ||
                classRoom.userAssignedClassId == 'null'
            ? Row(
                children: [
                  Container(
                    child: Center(
                      child: TextButton(
                        onPressed: () async {
                          final result = await showDialog<bool>(
                              context: context,
                              builder: (_) {
                                return CustomDialogBox(
                                    widget: BlocProvider.value(
                                  value:
                                      BlocProvider.of<ManagementCubit>(context),
                                  child: Container(
                                      child: AssignTeacherToClassRoom(
                                    classRoom: classRoom,
                                  )),
                                ));
                              });
                          if (result!) {
                            await classCubit.getFullDetailsOfClassRoom(
                                classRoomID: classRoom.id);
                          }
                        },
                        child: Text(
                          'No Teacher Assigned',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              color: blackColor),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            // :
            : FutureBuilder<User>(
                future: BlocProvider.of<ManagementCubit>(context)
                    .getUser(userID: classRoom.userAssignedClassId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: progressIndicator,
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {},
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600'),
                              radius: 20,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              snapshot.data!.name.trim(),
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: blackColor),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Assigned Teacher',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            color: blackColor),
                      ),
                      Text(
                        snapshot.data!.email,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            color: primaryColor),
                      )
                    ],
                  );
                },
              )
      ]),
    );
  }
}

class ClassRoomDashBoardWidget extends StatefulWidget {
  ClassRoom classRoom;
  ClassRoomDashBoardWidget({Key? key, required this.classRoom})
      : super(key: key);

  @override
  State<ClassRoomDashBoardWidget> createState() =>
      _ClassRoomDashBoardWidgetState(classRoom);
}

class _ClassRoomDashBoardWidgetState extends State<ClassRoomDashBoardWidget> {
  ClassRoom classRoom;
  _ClassRoomDashBoardWidgetState(this.classRoom);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10)
          ],
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  // width: 300,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [primaryColor, secondaryColor],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                    boxShadow: const [
                      BoxShadow(
                          color: blendColor, blurRadius: 15, spreadRadius: 10)
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today\'s Attendance',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  color: whiteColor),
                            ),
                            Text(
                              '48',
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor),
                            ),
                            Text(
                              'present out of 56',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  color: whiteColor.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                // await Navigator.of(context)
                                //     .push(MaterialPageRoute(builder: (_) {
                                //   return MultiBlocProvider(providers: [
                                //     BlocProvider.value(
                                //         value: BlocProvider.of<AdminCubit>(
                                //             context)),
                                //     BlocProvider(
                                //         create: (context) => ManagementCubit(
                                //             awsApiClient: getIt<AWSApiClient>(),
                                //             managementMode:
                                //                 ManagementMode.Teachers)),
                                //   ], child: const AttendanceOfClassroomPage());
                                // }));
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialogBox(
                                        widget: const Center(
                                          child: Text('Attendnace Details'),
                                        ),
                                      );
                                    });
                              },
                              child: const Text('View'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(
                width: 80.w,
              ),
              Expanded(
                child: Container(
                  // width: 300,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(
                              'Classroom Concentration',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: blackColor),
                            ),
                            Text(
                              '92%',
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: blackColor),
                            ),
                            Text(
                              'present',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  color: whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
           SizedBox(
            height: 10.h,
          ),
          // const Divider(
          //   color: primaryColor,
          //   indent: 10,
          //   endIndent: 10,
          //   thickness: 0.5,
          // ),
           SizedBox(
            height: 10.h,
          ),
           Text(
            'Students',
            style: TextStyle(
                fontSize: 24.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: blackColor),
          ),
           SizedBox(
            height: 20.h,
          ),
          classRoom.students == null
              ? const Expanded(
                  child: SizedBox(
                    height: double.maxFinite,
                    child: Center(child: Text('No Students Added')),
                  ),
                )
              : Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    child: AnimationLimiter(
                        child: GridView.count(
                            crossAxisSpacing: 10,
                            crossAxisCount: 8,
                            physics: const BouncingScrollPhysics(),
                            children: List.generate(classRoom.students!.length,
                                (index) {
                              return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 500),
                                  columnCount: 4,
                                  child: ScaleAnimation(
                                    duration: const Duration(milliseconds: 900),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: FadeInAnimation(
                                      child: StudentCard(
                                        student: classRoom.students![index],
                                      ),
                                    ),
                                  ));
                            }))),
                  ),
                ),
        ]));
  }
}

class ClassDetailsSideMenu extends StatefulWidget {
  ClassRoom classRoom;
  ClassDetailsSideMenu({Key? key, required this.classRoom}) : super(key: key);

  @override
  State<ClassDetailsSideMenu> createState() => _ClassDetailsSideMenuState();
}

class _ClassDetailsSideMenuState extends State<ClassDetailsSideMenu> {
  @override
  Widget build(BuildContext context) {
    final managementCubit = BlocProvider.of<ManagementCubit>(context);
    final classCubit = BlocProvider.of<ClassDetailsCubit>(context);
    return Container(
      margin:  EdgeInsets.only(left: 20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
        boxShadow: [
          BoxShadow(
              color: primaryColor.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 5)
        ],
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.3.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           SizedBox(
            height: 10.h,
          ),
           Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Manage Classroom',
              style: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: whiteColor),
            ),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextButton(
                onPressed: () async {
                  await classCubit.getAttendanceListDateWise(
                      classRoomID: widget.classRoom.id);
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return MultiBlocProvider(providers: [
                      BlocProvider.value(
                          value: BlocProvider.of<AdminCubit>(context)),
                      BlocProvider.value(
                          value: BlocProvider.of<ClassDetailsCubit>(context))
                    ], child: DownloadAttedance());
                  }));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return DownloadAttedance();
                  // }));
                },
                text: 'Download Attendance',
                bgColor: whiteColor,
                textColor: primaryColor,
              ),
               SizedBox(
                height: 10,
              ),
              CustomTextButton(
                onPressed: () async {
                  final result = await showModalSideSheet<bool>(
                      context: context,
                      body: MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                                value:
                                    BlocProvider.of<ManagementCubit>(context))
                          ],
                          child: AddStudentToClassRoom(
                            classRoom: widget.classRoom,
                          )));
                  if (result != null) {
                    await classCubit.getFullDetailsOfClassRoom(
                        classRoomID: widget.classRoom.id);
                  }
                },
                text: 'Add Student',
                bgColor: whiteColor,
                textColor: primaryColor,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextButton(
                onPressed: () async {
                  var classRoom = classCubit.classRoom;
                  final result = await showDialog<bool>(
                      context: context,
                      builder: (_) {
                        return CustomDialogBox(
                            widget: BlocProvider.value(
                          value: BlocProvider.of<ManagementCubit>(context),
                          child: Container(
                              child: AssignTeacherToClassRoom(
                            classRoom: classRoom,
                          )),
                        ));
                      });
                  if (result!) {
                    await classCubit.getFullDetailsOfClassRoom(
                        classRoomID: classRoom.id);
                  }
                },
                text: 'Assign Teacher',
                bgColor: whiteColor,
                textColor: primaryColor,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextButton(
                onPressed: () async {
                  await managementCubit.deleteClassRoom(
                      classRoomID: widget.classRoom.id);
                  await managementCubit.getAllClassRooms(limit: 10);
                  Navigator.pop(context);
                },
                text: 'Delete Class',
                bgColor: whiteColor,
                textColor: blackColor,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

// class SearchForTeacherToAssign extends StatefulWidget {
//   const SearchForTeacherToAssign({Key? key}) : super(key: key);

//   @override
//   State<SearchForTeacherToAssign> createState() =>
//       SearchForTeacherToAssignState();
// }

// class SearchForTeacherToAssignState extends State<SearchForTeacherToAssign> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
