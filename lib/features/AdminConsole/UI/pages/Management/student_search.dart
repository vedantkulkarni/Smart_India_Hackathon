import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/models/Student.dart';

import '../../../../../core/cubit/search_cubit.dart';

class StudentSearch extends StatefulWidget {
  const StudentSearch({Key? key}) : super(key: key);

  @override
  State<StudentSearch> createState() => _StudentSearchState();
}

class _StudentSearchState extends State<StudentSearch> {
  @override
  Widget build(BuildContext context) {
    final searchCubit = BlocProvider.of<SearchCubit>(context);
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is Searching) {
          return progressIndicator;
        } else if (state is SearchInitial) {
          return const Center(
            child: Text('Search for Students....'),
          );
        } else if (state is NoResultFound) {
          return const Center(
            child: Text('No result found for your search query'),
          );
        }

        return Expanded(
          child: Container(
            padding: const EdgeInsets.all(0),
            child: AnimationLimiter(
                child: GridView.count(
                    crossAxisSpacing: 10,
                    crossAxisCount: 6,
                    physics: const BouncingScrollPhysics(),
                    children:
                        List.generate(searchCubit.studentList.length, (index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 300),
                        columnCount: 4,
                        child: FadeInAnimation(
                          child: StudentSearchResult(
                            student: searchCubit.studentList[index],
                            onTap: () {
                              Navigator.pop(
                                  context, searchCubit.studentList[index]);
                            },
                          ),
                        ),
                      );
                    }))),
          ),
        );
      },
    );
  }
}

class StudentSearchResult extends StatefulWidget {
  VoidCallback onTap;
  Student student;
  StudentSearchResult({Key? key, required this.onTap, required this.student})
      : super(key: key);

  @override
  State<StudentSearchResult> createState() => _StudentSearchResultState();
}

class _StudentSearchResultState extends State<StudentSearchResult> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: textFieldFillColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600',
                ),
                radius: 18,
              ),
              FittedBox(
                child: Text(widget.student.studentName.trim().split(' ')[0],
                    style: const TextStyle(
                        color: primaryColor,
                        fontFamily: 'Poppins',
                        fontSize: 14)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
