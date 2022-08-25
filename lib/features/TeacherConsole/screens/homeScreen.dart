import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/Auth/UI/pages/login_screen.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_class_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/fab.dart';
import '../../../core/constants.dart';
import '../../../injection_container.dart';
import '../../AdminConsole/Backend/aws_api_client.dart';
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
  var _langStatus;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Builder(builder: (context) {
        return const Fab();
      }),
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

          if (state is CredentialsNotCorrect) {
            return Scaffold(
              body: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Credentials not correct"),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 100,
                        child: CustomTextButton(
                          onPressed: () async {
                            await Amplify.Auth.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          text: 'Try Again',
                        ),
                      ),
                    ],
                  )),
            );
          }

          if (state is SchoolNotFound) {
            return const SchoolNotFoundPage();
          }

          final teacherCubit = BlocProvider.of<TeacherCubit>(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  icon: const Icon(
                    Icons.notifications,
                    size: 35,
                    color: primaryColor,
                  ),
                  iconSize: 14,
                  alignment: Alignment.centerLeft,
                  underline: Container(),
                  borderRadius: BorderRadius.circular(10),
                  value: _langStatus,
                  onChanged: (val) async {
                    _langStatus = val;
                  },
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      child: Center(
                        child: Text(
                          'English',
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      ),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Center(
                        child: Text(
                          'Hindi',
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      ),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Center(
                        child: Text(
                          'Marathi',
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      ),
                      value: 3,
                    ),
                  ],
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: primaryColor,
                      child: CircleAvatar(
                        radius: 23,
                        backgroundImage: NetworkImage(
                            "https://image.shutterstock.com/image-photo/profile-picture-smiling-millennial-asian-260nw-1836020740.jpg"),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                TeacherDetail(
                  height: h,
                  width: w,
                  name: teacherCubit.teacher.name,
                  email: teacherCubit.teacher.email,
                  phone: teacherCubit.teacher.phoneNumber,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: greyColor,
                  ),
                ),
                // const SizedBox(height: 20,),
                (teacherCubit.teacher.assignedClass == null ||
                        teacherCubit.teacher.assignedClass!.isEmpty)
                    ? Expanded(
                        child: Container(
                          child: const Center(
                              child: Text('No Classrooms Assigned Yet !')),
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: StaggeredGrid.count(
                                crossAxisCount: 4,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 10,
                                children: List.generate(
                                  teacherCubit.teacher.assignedClass!.length,
                                  (index) => StaggeredGridTile.count(
                                    crossAxisCellCount: 2,
                                    mainAxisCellCount: 2,
                                    child: ClassTile(
                                      width: w,
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (_) {
                                          return MultiBlocProvider(
                                              providers: [
                                                BlocProvider.value(
                                                    value: BlocProvider.of<
                                                        TeacherCubit>(context)),
                                                BlocProvider(
                                                  key: ValueKey(teacherCubit
                                                      .teacher
                                                      .assignedClass![index]
                                                      .id
                                                      .toString()),
                                                  create: (context) =>
                                                      TeacherClassCubit(
                                                          awsApiClient: getIt<
                                                              AWSApiClient>(),
                                                          school: teacherCubit
                                                              .school,
                                                          classRoomID:
                                                              teacherCubit
                                                                  .teacher
                                                                  .assignedClass![
                                                                      index]
                                                                  .id),
                                                ),
                                              ],
                                              child: ClassDetailScreen(
                                                className: teacherCubit
                                                    .teacher
                                                    .assignedClass![index]
                                                    .classRoomName,
                                              ));
                                        }));
                                      },
                                      classNo: teacherCubit.teacher
                                          .assignedClass![index].classRoomName,
                                      noOfStd: teacherCubit
                                                  .teacher
                                                  .assignedClass![index]
                                                  .students ==
                                              null
                                          ? ''
                                          : teacherCubit
                                              .teacher
                                              .assignedClass![index]
                                              .students!
                                              .length
                                              .toString(),
                                    ),
                                  ),
                                )),
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
