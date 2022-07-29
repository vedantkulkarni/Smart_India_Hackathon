import 'package:fluent_ui/fluent_ui.dart';

class DatabasePage extends StatefulWidget {
  DatabasePage({Key? key}) : super(key: key);

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Database Page")),
    );
  }
}
