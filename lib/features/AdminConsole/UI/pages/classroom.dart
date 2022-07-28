import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Backend/admin_bloc/admin_cubit.dart';
import '../widgets/create_classroom.dart';
import '../widgets/custom_textbutton.dart';

class ClassRoomPage extends StatefulWidget {
  const ClassRoomPage({Key? key}) : super(key: key);

  @override
  State<ClassRoomPage> createState() => _ClassRoomPageState();
}

class _ClassRoomPageState extends State<ClassRoomPage> {
  @override
  Widget build(BuildContext context) {
    return  Container(
          child: Center(
        child: CustomTextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<AdminCubit>(context),
                        child: CreateClassRoom(),
                      )));
            },
            text: 'Create Class Room'),
      ));
    
  }
}
