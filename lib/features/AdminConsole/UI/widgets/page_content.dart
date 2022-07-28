import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/create_classroom.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';

class PageContent extends StatefulWidget {
  const PageContent({Key? key}) : super(key: key);

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
          child: CustomTextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<AdminCubit>(context),
                          child: CreateClassRoom(),
                        )));
              },
              text: 'Create Class Room')),
    );
  }
}
