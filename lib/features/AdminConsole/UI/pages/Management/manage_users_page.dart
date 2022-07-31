import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/user_profile_card.dart';

import '../../../../../core/constants.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({Key? key}) : super(key: key);

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  @override
  Widget build(BuildContext context) {
    final managementCubit = BlocProvider.of<ManagementCubit>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        actions: [Container()],
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: blackColor),
      ),
      body: BlocBuilder<ManagementCubit, ManagementState>(
        builder: (context, state) {
          if (state is ManagementInitial ||
              state is FetchingUsers ||
              state is DeletingUser) {
            return progressIndicator;
          }

          return Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: GridView.count(
                  crossAxisCount: 4,
                  children: List.generate(
                      managementCubit.usersList.length,
                      (index) => ProfileTile(
                          user: managementCubit.usersList[index]))));
        },
      ),
    );
  }
}
