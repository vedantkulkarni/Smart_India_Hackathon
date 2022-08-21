import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/user_profile_card.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textfield.dart';

import '../../../../../core/constants.dart';
import '../../../../../injection_container.dart';
import '../../../../../models/Role.dart';
import '../../../Backend/admin_bloc/admin_cubit.dart';
import '../../../Backend/aws_api_client.dart';
import 'add_user_page.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({Key? key}) : super(key: key);

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  Role role = Role.SuperAdmin;
  @override
  Widget build(BuildContext context) {
    final managementCubit = BlocProvider.of<ManagementCubit>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: BlocBuilder<ManagementCubit, ManagementState>(
        builder: (context, state) {
          if (state is ManagementInitial ||
              state is FetchingUsers ||
              state is DeletingUser) {
            return progressIndicator;
          }

          return Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      Text('Show',
                          style: TextStyle(
                              color: blackColor,
                              fontFamily: 'Poppins',
                              fontSize: 14.sp)),
                      SizedBox(
                        width: 10.w,
                      ),
                      DropdownButton<int>(
                        icon: null,
                        iconSize: 14,
                        elevation: 4,
                        alignment: Alignment.center,
                        underline: Container(),
                        borderRadius: BorderRadius.circular(10),
                        value: 10,
                        onChanged: (value) {},
                        items: [
                          DropdownMenuItem(
                            child: Text('10',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontFamily: 'Poppins',
                                    fontSize: 14.sp)),
                            value: 10,
                          ),
                          DropdownMenuItem(
                              child: Text('20',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'Poppins',
                                      fontSize: 14.sp)),
                              value: 20),
                          DropdownMenuItem(
                              child: Text('30',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'Poppins',
                                      fontSize: 14.sp)),
                              value: 30)
                        ],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      DropdownButton<Role>(
                        icon: null,
                        iconSize: 14,
                        alignment: Alignment.center,
                        underline: Container(),
                        borderRadius: BorderRadius.circular(10),
                        value: role,
                        onChanged: (value) {
                          managementCubit.clearUserList();
                          role = value!;
                          managementCubit.getAllUsers(role: value);
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text('SuperAdmin',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontFamily: 'Poppins',
                                    fontSize: 14.sp)),
                            value: Role.SuperAdmin,
                          ),
                          DropdownMenuItem(
                              child: Text('Admin',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'Poppins',
                                      fontSize: 14.sp)),
                              value: Role.Admin),
                          DropdownMenuItem(
                              child: Text('Teacher',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'Poppins',
                                      fontSize: 14.sp)),
                              value: Role.Teacher)
                        ],
                      ),
                      const Spacer(),
                      CustomTextButton(
                          onPressed: () async {
                            await Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return MultiBlocProvider(providers: [
                                BlocProvider.value(
                                    value:
                                        BlocProvider.of<AdminCubit>(context)),
                                BlocProvider(
                                    create: (context) => ManagementCubit(
                                        awsApiClient: getIt<AWSApiClient>(),
                                        managementMode:
                                            ManagementMode.Teachers)),
                              ], child: const AddUserPage());
                            }));

                            await BlocProvider.of<ManagementCubit>(context)
                                .getAllUsers(role: role);
                          },
                          text: 'Add User'),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: CustomTextField(
                          hintText: 'Search',
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 20.h),
                          width: 300.w,
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: GridView.count(
                      crossAxisCount: 4,
                      children: List.generate(
                          (state as UsersFetched).userList.length,
                          (index) =>
                              UserProfileCard(user: (state).userList[index]))),
                ),
              ),
              // const Text('Showing 10 out of 50 items',
              //     style: TextStyle(
              //         color: blackColor, fontFamily: 'Poppins', fontSize: 14)),
            ],
          ));
        },
      ),
    );
  }
}
