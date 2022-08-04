import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_cubit.dart';
import '../../../core/constants.dart';
import '../../AdminConsole/UI/widgets/school_not_found.dart';
import '../widgets/classTile.dart';
import '../widgets/teacherInfo.dart';
import 'classDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocBuilder<TeacherCubit, TeacherState>(
        builder: (context, state) {
          if (state is TeacherInitial || state is FetchingTeacher) {
          return const Scaffold(
            body: SizedBox(
                child: Center(
              child: CircularProgressIndicator(),
            )),
          );
        }

        if (state is SchoolNotFound) {
          return const SchoolNotFoundPage();
        }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: const Icon(
                Icons.notifications,
                size: 35,
                color: primaryColor,
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.info_outline,
                    size: 35,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                TeacherDetail(
                  height: h,
                  width: w,
                  name: 'Rohin Bhat',
                  email: 'atk@gmail.com',
                  phone: '9922889487',
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: greyColor,
                  ),
                ),
                // const SizedBox(height: 20,),
                Expanded(
                  child: SingleChildScrollView(
                    child: StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 6,
                      children: [
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: ClassTile(
                            width: w,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const ClassDetailScreen(
                                  className: 'TE-01',
                                );
                              }));
                            },
                            classNo: 'TE-01',
                            noOfStd: '89',
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: ClassTile(
                            width: w,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const ClassDetailScreen(
                                    className: 'TE-01');
                              }));
                            },
                            classNo: 'TE-02',
                            noOfStd: '87',
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: ClassTile(
                            width: w,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const ClassDetailScreen(
                                    className: 'TE-01');
                              }));
                            },
                            classNo: 'TE-03',
                            noOfStd: '98',
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: ClassTile(
                            width: w,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const ClassDetailScreen(
                                    className: 'TE-01');
                              }));
                            },
                            classNo: 'TE-04',
                            noOfStd: '85',
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: ClassTile(
                            width: w,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const ClassDetailScreen(
                                    className: 'TE-01');
                              }));
                            },
                            classNo: 'TE-03',
                            noOfStd: '98',
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: ClassTile(
                            width: w,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const ClassDetailScreen(
                                    className: 'TE-01');
                              }));
                            },
                            classNo: 'TE-04',
                            noOfStd: '85',
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
