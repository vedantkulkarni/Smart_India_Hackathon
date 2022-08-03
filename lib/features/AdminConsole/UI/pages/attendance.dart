import 'package:fluent_ui/fluent_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team_dart_knights_sih/core/constants.dart';

import '../widgets/custom_textfield.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool show = true;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return BodyWithSideSheet(
      show: show,
      body: const AttendanceWidget(),
      sheetWidth: 400,
      sheetBody: Container(
        color: navPanecolor,
        padding: const EdgeInsets.all(10),
        child: TableCalendar(
          pageAnimationEnabled: true,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
            CalendarFormat.week: 'Week',
          },
          focusedDay: focusedDay,
          firstDay: DateTime(1999),
          lastDay: DateTime(2050),
          calendarFormat: format,
          onFormatChanged: (CalendarFormat _format) {
            setState(() {
              format = _format;
            });
          },
          startingDayOfWeek: StartingDayOfWeek.sunday,
          daysOfWeekVisible: true,
          onDayLongPressed: (DateTime selectedDay, DateTime focusDay) {},
          onDaySelected: (DateTime selectDay, DateTime focusDay) {
            setState(() {
              selectedDay = selectDay;
              focusedDay = focusDay;
            });
          },
          selectedDayPredicate: (DateTime date) {
            return isSameDay(selectedDay, date);
          },
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: primaryColor,
            ),
            selectedTextStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: whiteColor),
            todayDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: primaryColor,
            ),
            todayTextStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: blackColor),
            defaultDecoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            defaultTextStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: blackColor),
            weekendDecoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            weekendTextStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: blackColor),
          ),
          headerStyle: HeaderStyle(
            leftChevronIcon: const FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: primaryColor,
              size: 16,
            ),
            rightChevronIcon: const FaIcon(
              FontAwesomeIcons.chevronRight,
              color: primaryColor,
              size: 16,
            ),
            headerMargin: const EdgeInsets.only(bottom: 20),
            // decoration: BoxDecoration(
            //   color: const Color(0xFFAB47BC).withOpacity(0.0),
            //   borderRadius: BorderRadius.circular(16),
            // ),
            titleTextStyle: const TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: blackColor),
            formatButtonVisible: true,
            titleCentered: true,
            formatButtonShowsNext: false,
            formatButtonDecoration: BoxDecoration(
              color: const Color(0xFFBBDEFB),
              borderRadius: BorderRadius.circular(5.0),
            ),
            formatButtonTextStyle: const TextStyle(
              color: Color(0xFF1A237E),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class AttendanceWidget extends StatelessWidget {
  const AttendanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          const SizedBox(
            width: 20,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: CustomTextField(
              hintText: 'Search',
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              prefixIcon: const Icon(
                FluentIcons.search,
                size: 16,
              ),
            ),
          ),
          /*DataTable2(
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
                size: ColumnSize.L,
              ),
              DataColumn(
                label: Text('Phone'),
              ),
              DataColumn(
                label: Text('Email'),
              ),
              DataColumn(label: Text('Gender')),
            ],
            rows: List<DataRow>.generate(
              4,
                  (index) => DataRow2.byIndex(
                  selected: true,
                  color: null,
                  index: index,
                  onTap: () {},
                  cells: [
                    DataCell(
                      Text(
                        'Harsh',
                      ),
                    ),
                    DataCell(
                      Text(
                        '9922929',
                      ),
                    ),
                    DataCell(
                      Text(
                        'ahah@gmail.com',
                      ),
                    ),
                    DataCell(
                      Text(
                        'Male',
                      ),
                    ),
                  ]),
            )
          ),*/
        ],
      ),
    );
  }
}
