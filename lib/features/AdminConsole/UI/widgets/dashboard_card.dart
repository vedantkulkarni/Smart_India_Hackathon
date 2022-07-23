import 'package:fluent_ui/fluent_ui.dart';
import 'package:team_dart_knights_sih/core/constants.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 15)
            ],
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: primaryColor),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Students',
                    style: TextStyle(
                        color: greyColor, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '302',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          )),
    );
  }
}
