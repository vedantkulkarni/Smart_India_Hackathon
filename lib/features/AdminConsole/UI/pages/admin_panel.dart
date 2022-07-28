import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/add_users.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/attendance.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/dashboard.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/database.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/settings.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/school_not_found.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/side_menu.dart';

import '../widgets/page_content.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int index = 0;

  // final List<NavigationPaneItem> navItem = [
  //   PaneItem(
  //     selectedTileColor: ButtonState.all(primaryColor.withOpacity(0.2)),
  //     icon: const Icon(FluentIcons.b_i_dashboard),
  //     title: const Text(
  //       'Dashboard',
  //     ),
  //     infoBadge: const InfoBadge(
  //       source: Text('9'),
  //     ),
  //   ),
  //   PaneItem(
  //     icon: const Icon(FluentIcons.graph_symbol),
  //     title: const Text('Attendance'),
  //   ),
  //   PaneItem(
  //     icon: const Icon(FluentIcons.database),
  //     title: const Text('Database'),
  //   ),
  //   PaneItem(
  //     icon: const Icon(FluentIcons.add_group),
  //     title: const Text('Add Users'),
  //   ),
  //   PaneItem(
  //     icon: const Icon(FluentIcons.settings),
  //     title: const Text('Settings'),
  //   ),
  // ];

  List screens = [
    const Dashboard(),
    AttendancePage(),
    DatabasePage(),
    AddUsers(),
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
              children: const [
                Flexible(flex: 1, child: SideMenu()),
                VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: greyColor,
                ),
                Flexible(flex: 2, child: PageContent()),
              ],
            ),
          ),
        );
      },
    );
  }
}
