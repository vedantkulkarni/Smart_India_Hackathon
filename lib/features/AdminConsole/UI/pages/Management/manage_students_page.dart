import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/view_and_edit_user.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textfield.dart';

import '../../../../../injection_container.dart';
import '../../../Backend/admin_bloc/admin_cubit.dart';
import '../../../Backend/aws_api_client.dart';
import 'add_user_page.dart';

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
              state is FetchingTeachers ||
              state is DeletingUser) {
            return progressIndicator;
          }

          return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: CustomTextField(
                          hintText: 'Search',
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          width: 400,
                          prefixIcon: const Icon(
                            FluentIcons.search_12_filled,
                            size: 16,
                          ),
                        ),
                      ),
                      // const Spacer(),
                      SizedBox(
                          width: 200,
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
                                  ], child: const AddUserPage());
                                }));

                                // _key.currentState!.openEndDrawer();
                                // await showModalSideSheet(
                                //     transitionDuration:
                                //         const Duration(milliseconds: 100),
                                //     context: context,
                                //     ignoreAppBar: false,
                                //     body:  TeacherDetailsPage(user: null,));

                                await BlocProvider.of<ManagementCubit>(context)
                                    .fetchAllTeachers();
                              },
                              text: 'Add Teacher')),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                            child: const Center(
                          child: Text('No Teachers added yet'),
                        )),
                        dataTextStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            color: blackColor),
                        headingTextStyle: const TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                        columns: const [
                          DataColumn2(
                            label: Text(
                              'Name',
                            ),
                            size: ColumnSize.L,
                          ),
                          DataColumn(
                            label: Text('Phone'),
                          ),
                          DataColumn(
                            label: Text('Email'),
                          ),
                          DataColumn(label: Text('Gender')),
                        ],
                        rows: List<DataRow>.generate(
                          (state as TeachersFetched).teacherList.length,
                          (index) => DataRow2.byIndex(
                              selected: true,
                              color: MaterialStateProperty.all(whiteColor),
                              index: index,
                              onTap: () async {
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
                                //   ], child: const AddTeacherPage());
                                // }));
                                // index = 1;
                                // _key.currentState!.openEndDrawer();
                                final res = await showModalSideSheet<bool>(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    context: context,
                                    ignoreAppBar: false,
                                    body: BlocProvider.value(
                                      value: BlocProvider.of<ManagementCubit>(
                                          context),
                                      child: ViewAndEditUser(
                                        user: (state).teacherList[index],
                                      ),
                                    ));
                                if (res != null && res == true) {
                                  await BlocProvider.of<ManagementCubit>(
                                          context)
                                      .fetchAllTeachers();
                                }
                              },
                              cells: [
                                DataCell(
                                  Text(
                                    (state).teacherList[index].name,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    (state).teacherList[index].phoneNumber,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    (state).teacherList[index].email,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    (state).teacherList[index].gender!,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ));
        },
      ),
    );
  }
}
