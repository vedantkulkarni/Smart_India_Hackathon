import 'package:fluent_ui/fluent_ui.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/dashboard.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int index = 0;

  final List<NavigationPaneItem> navItem = [
    PaneItem(
      icon: const Icon(FluentIcons.b_i_dashboard),
      title: const Text('Dashboard'),
      infoBadge: const InfoBadge(
        source: Text('9'),
      ),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.graph_symbol),
      title: const Text('Attendance'),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.database),
      title: const Text('Database'),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.settings),
      title: const Text('Settings'),
    ),
  ];

  List screens = [const Dashboard()];

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: NavigationBody.builder(
        index: index,
        itemBuilder: (context, index) {
          return screens[index];
        },
      ),
      pane: NavigationPane(
          header: Container(
            height: 200,
            width: double.maxFinite,
            color: primaryColor,
            child: const Text("Smart Attendance App"),
          ),
          footerItems: [],
          items: navItem,
          selected: index,
          onChanged: (value) => index = value,
          displayMode: PaneDisplayMode.auto),
    );
  }
}
