import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_class_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/mark_attendance.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/screens/student_detail_screen.dart';
import 'package:team_dart_knights_sih/injection_container.dart';

import '../widgets/student_profile_widget.dart';

class ClassDetailScreen extends StatefulWidget {
  final String className;
  const ClassDetailScreen({required this.className, Key? key})
      : super(key: key);

  @override
  _ClassDetailScreenState createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final teacherCubit = BlocProvider.of<TeacherCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<TeacherClassCubit, TeacherClassState>(
        builder: (context, state) {
          if (state is TeacherClassInitial) {
            return progressIndicator;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: h * 0.15,
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    border: Border.all(color: greyColor)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        height: h * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: backgroundColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Class',
                          style: TextStyle(
                              color: backgroundColor,
                              fontSize: w * 0.1,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.className,
                          style: TextStyle(
                              color: backgroundColor,
                              fontSize: w * 0.1,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Students',
                  style: TextStyle(
                      color: navIconsColor,
                      fontSize: 45,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: h * 0.5,
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: const [
                        BoxShadow(
                            color: navIconsColor,
                            blurRadius: 2,
                            spreadRadius: 2)
                      ],
                      border: Border.all(color: Colors.black)),
                  child: StaggeredGrid.count(
                    crossAxisCount: 10,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 6,
                    children: [
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: StudentProfileWidget(
                          name: 'Harsh',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const StudentDetailScreen(
                                name: 'Harsh',
                                email: 'atk@gmail.com',
                                address: 'Pune',
                                attendance: '89%',
                              );
                            }));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () async {
                  
                  await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) {
                    return MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: teacherCubit,
                          ),
                          BlocProvider.value(
                            value: BlocProvider.of<TeacherClassCubit>(context),
                          ),
                          BlocProvider(
                              create: (context) => AttendanceCubit(
                                  apiClient: getIt<AWSApiClient>()))
                        ],
                        child: MarkAttendnacePage(
                          cameras: BlocProvider.of<TeacherClassCubit>(context)
                              .camerasList,
                        ));
                  }));
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: h * 0.1,
                      decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Mark Attendance',
                            style: TextStyle(
                                color: backgroundColor,
                                fontSize: 25,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
