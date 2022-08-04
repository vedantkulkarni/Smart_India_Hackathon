import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants.dart';
import '../../widgets/custom_textbutton.dart';
import 'cubit/management_cubit.dart';

class StudentDetailsPage extends StatefulWidget {
  StudentDetailsPage({Key? key}) : super(key: key);

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: navIconsColor),
      ),
      body: Container(
        color: backgroundColor,
        child: BlocBuilder<ManagementCubit, ManagementState>(
          builder: (context, state) {
            if (state is AddingUser) {
              return progressIndicator;
            }

            return Container(
              child: Row(
                children: [
                  
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
