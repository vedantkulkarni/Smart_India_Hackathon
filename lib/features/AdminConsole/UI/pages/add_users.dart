import 'package:fluent_ui/fluent_ui.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/add_user_card.dart';

import '../../../../core/constants.dart';

class AddUsers extends StatefulWidget {
  AddUsers({Key? key}) : super(key: key);

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                AddUserCard(),
                AddUserCard(),
                AddUserCard(),
              ],
            )
          ],
        ),
      ),
    );
  }
}