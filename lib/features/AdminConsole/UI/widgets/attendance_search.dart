import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/cubit/search_cubit.dart';

import '../../../../core/constants.dart';
import '../../../../models/AttendanceStatus.dart';

class AttendanceSearch extends StatelessWidget {
  const AttendanceSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchCubit = BlocProvider.of<SearchCubit>(context);
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is Searching) {
          return progressIndicator;
        } else if (state is SearchInitial) {
          return const Center(
            child: Text('Search for Attendance....'),
          );
        } else if (state is NoResultFound) {
          return const Center(
            child: Text('No result found for your search query'),
          );
        }
        return DataTable2(
            dataRowColor:
                MaterialStateProperty.all(primaryColor.withOpacity(0.1)),
            dataTextStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: blackColor),
            headingTextStyle: const TextStyle(
                fontSize: 16,
                color: blackColor,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
            columns: const [
              DataColumn2(
                label: Text(
                  'Name',
                ),
                size: ColumnSize.M,
              ),
              DataColumn2(
                label: Text(
                  'Status',
                ),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text(
                  'Verification Mode',
                ),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text(
                  'Status',
                ),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text(
                  'Teacher',
                ),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text(
                  'Date',
                ),
                size: ColumnSize.S,
              ),
            ],
            rows: List<DataRow>.generate(
              searchCubit.attendanceList.length,
              (index) => DataRow2.byIndex(
                  selected: true,
                  color: searchCubit.attendanceList[index].status ==
                          AttendanceStatus.Absent
                      ? MaterialStateProperty.all(Colors.red.withOpacity(0.1))
                      : null,
                  index: index,
                  onTap: () {},
                  cells: [
                    DataCell(
                      Text(
                        searchCubit.attendanceList[index].studentName,
                      ),
                    ),
                    DataCell(
                      Text(
                        searchCubit.attendanceList[index].status.name,
                      ),
                    ),
                    DataCell(
                      FittedBox(
                        child: Text(
                          searchCubit.attendanceList[index].verification.name,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        searchCubit.attendanceList[index].className,
                      ),
                    ),
                    DataCell(
                      Text(
                        searchCubit.attendanceList[index].teacherID,
                      ),
                    ),
                    DataCell(
                      Text(
                        searchCubit.attendanceList[index].date.toString(),
                      ),
                    ),
                  ]),
            ));
      },
    );
  }
}
