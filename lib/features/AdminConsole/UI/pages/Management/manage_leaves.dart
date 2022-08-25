import 'package:data_table_2/data_table_2.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:team_dart_knights_sih/core/constants.dart';

import '../../widgets/custom_textbutton.dart';
import '../../widgets/custom_textfield.dart';
import 'cubit/management_cubit.dart';

class ManageLeaves extends StatefulWidget {
  const ManageLeaves({Key? key}) : super(key: key);

  @override
  State<ManageLeaves> createState() => _ManageLeavesState();
}

class _ManageLeavesState extends State<ManageLeaves> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ManagementCubit, ManagementState>(
        builder: (context, state) {
          if (state is ManagementInitial ||
              state is FetchingLeaves ||
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: CustomTextField(
                          hintText: 'Search',
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          width: 400,
                          prefixIcon: const Icon(
                            Icons.arrow_back,
                            //FluentIcons.search_12_filled,
                            size: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                          width: 200.w,
                          child: CustomTextButton(
                              onPressed: () async {
                                // await showDialog(
                                //     context: context,
                                //     builder: (_) {
                                //       // return BlocProvider(
                                //       //   create: (_) => SearchCubit(
                                //       //       apiClient: getIt<AWSApiClient>(),
                                //       //       searchMode: SearchMode.Student),
                                //       //   child: CustomDialogBox(
                                //       //       widget: CommonSearch(
                                //       //     searchMode: SearchMode.Student,
                                //       //   )),
                                //       // );
                                //     });
                              },
                              text: 'Search'.tr)),
                      SizedBox(
                        width: 40.w,
                      ),
                      // SizedBox(
                      //     width: 200,
                      //     child: CustomTextButton(
                      //         onPressed: () async {}, text: 'Add Student'.tr)),
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
                          child: Text('No Leave Applications Found'.tr),
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
                            label: Text('Subject'.tr),
                          ),
                          DataColumn(
                            label: Text('Days'.tr),
                          ),
                          DataColumn(label: Text('Start From'.tr)),
                        ],
                        rows: List<DataRow>.generate(
                          (state as LeavesFetched).leaves.length,
                          (index) => DataRow2.byIndex(
                              selected: true,
                              color: MaterialStateProperty.all(whiteColor),
                              index: index,
                              onTap: () async {},
                              cells: [
                                DataCell(
                                  Text(
                                    (state).leaves[index].studentID,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    (state).leaves[index].leaveReason,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    (state).leaves[index].studentID,
                                  ),
                                ),
                                // DataCell(CircleAvatar(
                                //     backgroundImage: (state)
                                //                 .leaves[index]
                                //                 .leaveDate ==
                                //             null
                                //         ? Image.asset(
                                //                 'assets/images/studentManagement.png')
                                //             .image
                                //         : NetworkImage((state)
                                //             .studentsList[index]
                                //             .profilePhoto!))),
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
