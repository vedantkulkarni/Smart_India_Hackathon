import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/cubit/search_cubit.dart';

import '../../../../core/constants.dart';

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
                  'Student id',
                ),
                size: ColumnSize.L,
              ),
              DataColumn(
                label: Text('Status'),
              ),
              DataColumn(
                label: Text('Verification'),
              ),
              DataColumn(label: Text('Date')),
            ],
            rows: List<DataRow>.generate(
              searchCubit.attendanceList.length,
              (index) => DataRow2.byIndex(
                  selected: true,
                  color: null,
                  index: index,
                  onTap: () {},
                  cells: [
                    DataCell(
                      Text(
                        searchCubit.attendanceList[index].studentID,
                      ),
                    ),
                    DataCell(
                      Text(
                        searchCubit.attendanceList[index].status.name,
                      ),
                    ),
                    DataCell(
                      Text(
                        searchCubit.attendanceList[index].verification.name,
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
