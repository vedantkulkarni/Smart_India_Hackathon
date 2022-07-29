import 'package:data_table_2/data_table_2.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/add_teacher.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textfield.dart';

import '../../../../../injection_container.dart';
import '../../../Backend/admin_bloc/admin_cubit.dart';
import '../../../Backend/aws_api_client.dart';

class MangeTeachersPage extends StatefulWidget {
  const MangeTeachersPage({Key? key}) : super(key: key);

  @override
  State<MangeTeachersPage> createState() => _MangeTeachersPageState();
}

class _MangeTeachersPageState extends State<MangeTeachersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: navIconsColor),
      ),
      body: BlocBuilder<ManagementCubit, ManagementState>(
        builder: (context, state) {
          print(state);
          if (state is ManagementInitial || state is FetchingTeachers) {
            return progressIndicator;
          }

          return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: CustomTextField(
                          hintText: 'Search',
                          labelText: 'Search',
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          width: 400,
                          prefixIcon: const Icon(
                            FluentIcons.search,
                            size: 16,
                          ),
                        ),
                      ),
                      // const Spacer(),
                      SizedBox(
                          width: 200,
                          child: CustomTextButton(
                              onPressed: () async {
                                Navigator.of(context)
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
                                  ], child: const AddTeacherPage());
                                }));
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
                              color: null,
                              index: index,
                              onTap: () {},
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
