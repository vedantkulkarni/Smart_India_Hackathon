import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/user_profile_card.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textfield.dart';
import 'package:get/get.dart';
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
      body: BlocConsumer<ManagementCubit, ManagementState>(
        listener: (context, state) {
          if (state is UserUpdated) {
            managementCubit.getAllUsers(role: role);
          }
        },
        builder: (context, state) {
          if (state is ManagementInitial ||
              state is FetchingUsers ||
              state is DeletingUser ||
              state is UpdatingUser) {
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
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  children: [
                    Text('Show'.tr,
                        style: TextStyle(
                            color: blackColor,
                            fontFamily: 'Poppins',
                            fontSize: 14.sp)),
                    SizedBox(
                      width: 10.w,
                    ),
                    
                    DropdownButton<Role>(
                      icon: null,
                      iconSize: 14.sp,
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
                          child: Text('SuperAdmin'.tr,
                              style: TextStyle(
                                  color: primaryColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp)),
                          value: Role.SuperAdmin,
                        ),
                        DropdownMenuItem(
                            child: Text('Admin'.tr,
                                style: TextStyle(
                                    color: primaryColor,
                                    fontFamily: 'Poppins',
                                    fontSize: 14.sp)),
                            value: Role.Admin),
                        DropdownMenuItem(
                            child: Text('Teachers'.tr,
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
                                  value: BlocProvider.of<AdminCubit>(context)),
                              BlocProvider(
                                  create: (context) => ManagementCubit(
                                      awsApiClient: getIt<AWSApiClient>(),
                                      managementMode: ManagementMode.Teachers,
                                      limit: 10)),
                            ], child: const AddUserPage());
                          }));

                          await BlocProvider.of<ManagementCubit>(context)
                              .getAllUsers(role: role);
                        },
                        text: 'Add User'.tr),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: CustomTextField(
                        hintText: 'Search'.tr,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 20.h),
                        width: 300.w,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
