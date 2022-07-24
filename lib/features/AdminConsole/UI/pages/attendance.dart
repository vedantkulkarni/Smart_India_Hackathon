import 'package:fluent_ui/fluent_ui.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Container(
        child: Center(child: Text("Attendance Page")),
      ),
    );
  }
}