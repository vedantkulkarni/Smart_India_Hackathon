import 'package:data_table_2/data_table_2.dart';
import 'package:fluent_ui/fluent_ui.dart' as fi;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/add_student_page.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/common_search.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/student_details_screen_admin_console.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import '../../../../../core/cubit/search_cubit.dart';
import '../../../../../injection_container.dart';
import '../../../../../models/Student.dart';
import '../../../Backend/admin_bloc/admin_cubit.dart';
import '../../../Backend/aws_api_client.dart';
import '../../widgets/custom_dialog_box.dart';

class ManageStudentsPage extends StatefulWidget {
  const ManageStudentsPage({Key? key}) : super(key: key);

  @override
  State<ManageStudentsPage> createState() => _ManageStudentsPageState();
}

class _ManageStudentsPageState extends State<ManageStudentsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawerEnableOpenDragGesture: false,
      body: BlocBuilder<ManagementCubit, ManagementState>(
        builder: (context, state) {
          if (state is ManagementInitial ||
              state is FetchingStudents ||
              state is DeletingStudent) {
            return progressIndicator;
          }

          return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: backgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.all(10),
                      //   child: CustomTextField(
                      //     hintText: 'Search',
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 10, vertical: 15),
                      //     width: 400,
                      //     prefixIcon: const Icon(
                      //       FluentIcons.search_12_filled,
                      //       size: 16,
                      //     ),
                      //   ),
                      // ),
                      const Spacer(),
                      SizedBox(
                          width: 200.w,
                          child: CustomTextButton(
                              onPressed: () async {
                                await showDialog(
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
                              },

                              text: 'Search'.tr)),
                      SizedBox(
                        width: 40.w,

                      ),
                      SizedBox(
                          width: 200.w,
                          child: CustomTextButton(
                              onPressed: () async {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return MultiBlocProvider(providers: [
                                    BlocProvider.value(
                                        value: BlocProvider.of<AdminCubit>(
                                            context)),
                                    BlocProvider(
                                        create: (context) => ManagementCubit(
                                            awsApiClient: getIt<AWSApiClient>(),
                                            managementMode:
                                                ManagementMode.Teachers)),
                                  ], child: const AddStudentsPage());
                                }));

                                await BlocProvider.of<ManagementCubit>(context)
                                    .getAllStudents(limit: 10);
                                // _key.currentState!.openEndDrawer();
                                // await showModalSideSheet(
                                //     transitionDuration:
                                //         const Duration(milliseconds: 100),
                                //     context: context,
                                //     ignoreAppBar: false,
                                //     body:  TeacherDetailsPage(student: null,));

                                // await BlocProvider.of<ManagementCubit>(context)
                                //     .fetchAllTeachers();
                              },
                              text: 'Add Student'.tr)),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: blendColor,
                              blurRadius: 15,
                              spreadRadius: 10)
                        ],
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DataTable2(
                        empty: Container(
                            child: Center(
                          child: Text('No Students added yet'.tr),
                        )),
                        dataTextStyle: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            color: blackColor),
                        headingTextStyle: TextStyle(
                            fontSize: 16.sp,
                            color: blackColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                        columns: [
                          DataColumn2(
                            label: Text(
                              'Name'.tr,
                            ),
                            size: ColumnSize.L,
                          ),
                          DataColumn(
                            label: Text('Phone'.tr),
                          ),
                          DataColumn(
                            label: Text('Email'.tr),
                          ),
                          DataColumn(label: Text('Profile'.tr)),
                        ],
                        rows: List<DataRow>.generate(
                          (state as StudentsFetched).studentsList.length,
                          (index) => DataRow2.byIndex(
                              selected: true,
                              color: MaterialStateProperty.all(whiteColor),
                              index: index,
                              onTap: () async {
                                // await showDialog(
                                //     context: context,
                                //     builder: (_) {
                                //       return BlocProvider.value(
                                //         value: BlocProvider.of<ManagementCubit>(
                                //             context),
                                //         child: CustomDialogBox(
                                //             widget: StudentDetailsDialog(
                                //           student: (state).studentsList[index],
                                //         )),
                                //       );
                                //     });
                                // await showDialog(
                                //     context: context,
                                //     builder: (_) {
                                //       return MultiBlocProvider(
                                //         providers: [
                                //           BlocProvider.value(
                                //               value:
                                //                   BlocProvider.of<AdminCubit>(
                                //                       context)),
                                //           BlocProvider.value(
                                //               value: BlocProvider.of<
                                //                   ManagementCubit>(context)),
                                //         ],
                                //         child: CustomDialogBox(
                                //           widget: StudentDetailsDialog(
                                //             student: state.studentsList[index],
                                //           ),
                                //         ),
                                //       );
                                //     });
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) {
                                //     return const StudentDetailScreenPartAdmin();
                                //   },
                                //));
                              },
                              cells: [
                                DataCell(
                                  Text(
                                    (state).studentsList[index].studentName,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    (state).studentsList[index].phoneNumber ??
                                        '-',
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    (state).studentsList[index].email ?? '-',
                                  ),
                                ),
                                DataCell(CircleAvatar(
                                    backgroundImage: (state)
                                                .studentsList[index]
                                                .profilePhoto ==
                                            null
                                        ? Image.asset(
                                                'assets/images/studentManagement.png')
                                            .image
                                        : NetworkImage((state)
                                            .studentsList[index]
                                            .profilePhoto!))),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  )
                ],
              ));
        },
      ),
    );
  }
}

class StudentDetailsDialog extends StatefulWidget {
  Student student;
  StudentDetailsDialog({Key? key, required this.student}) : super(key: key);

  @override
  State<StudentDetailsDialog> createState() =>
      _StudentDetailsDialogState(student);
}

class _StudentDetailsDialogState extends State<StudentDetailsDialog> {
  bool canEdit = false;
  Student student;
  _StudentDetailsDialogState(this.student);
  @override
  Widget build(BuildContext context) {
    final managementCubit = BlocProvider.of<ManagementCubit>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      canEdit = true;
                    });
                  },
                  icon: const Icon(
                    fi.FluentIcons.edit,
                    size: 16,
                    color: primaryColor,
                  )),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    fi.FluentIcons.check_mark,
                    size: 20,
                    color: primaryColor,
                  )),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 150.h,
              width: 150.w,
              child: CircleAvatar(
                backgroundColor: textFieldFillColor,
                child: Center(child: Icon(fi.FluentIcons.photo2_add)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              student.profilePhoto ?? 'Unknown',
              style: const TextStyle(color: greyColor, fontFamily: 'Poppins'),
            ),
            SizedBox(
              width: 10.w,
            ),
            const Text('|',
                style: TextStyle(color: primaryColor, fontFamily: 'Poppins')),
            SizedBox(
              width: 10.w,
            ),
            Text(student.profilePhoto == null ? 'Unknown' : '23',
                style:
                    const TextStyle(color: greyColor, fontFamily: 'Poppins')),
            SizedBox(
              width: 10.w,
            ),
            const Text('|',
                style: TextStyle(color: primaryColor, fontFamily: 'Poppins')),
            SizedBox(
              width: 10.w,
            ),
          ]),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  enabled: canEdit,
                  value: student.studentName.trim().split(' ')[0],
                  hintText: student.studentName.trim().split(' ')[0],
                  padding: const EdgeInsets.all(5),
                  heading: 'First Name',
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: CustomTextField(
                  enabled: canEdit,
                  hintText: student.studentName.trim().split(' ').length == 2
                      ? student.studentName.trim().split(' ')[1]
                      : student.studentName.trim().split(' ')[2],
                  value: student.studentName.trim().split(' ').length == 2
                      ? student.studentName.trim().split(' ')[1]
                      : student.studentName.trim().split(' ')[2],
                  padding: const EdgeInsets.all(5),
                  heading: 'Last Name',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  enabled: canEdit,
                  hintText: student.email ?? "Email",
                  value: student.email,
                  padding: const EdgeInsets.all(5),
                  heading: 'Email',
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: CustomTextField(
                  enabled: canEdit,
                  hintText: student.phoneNumber ?? 'Phone',
                  value: student.phoneNumber,
                  padding: const EdgeInsets.all(5),
                  heading: 'Phone Number',
                ),
              ),
            ],
          ),
          CustomTextField(
            enabled: canEdit,
            hintText: student.address ?? 'Unknown',
            value: student.address ?? 'Unknown',
            padding: const EdgeInsets.all(5),
            heading: 'Address',
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextButton(
                onPressed: () async {
                  print(student.id);
                  await managementCubit.deleteStudent(
                      studentID: student.studentID);
                  await managementCubit.getAllStudents(limit: 10);
                  Navigator.pop(context, true);
                },
                text: 'Delete',
                bgColor: redColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
