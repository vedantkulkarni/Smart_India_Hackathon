import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/management.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/attendance.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/dashboard.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/settings.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_sidemenu.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/school_not_found.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int index = 0;
  PageController page = PageController();

  List<Widget> screens = [
    const Dashboard(),
    const AttendancePage(),
    const Management(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        if (state is AdminInitial || state is CreatingSchool) {
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
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomSideMenu(
                  page: page,
                ),
                const VerticalDivider(
                  thickness: 0.5,
                  color: greyColor,
                  width: 0.5,
                ),
                Expanded(
                  child: PageView(controller: page, children: screens),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
