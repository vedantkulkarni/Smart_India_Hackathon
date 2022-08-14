import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team_dart_knights_sih/core/constants.dart';

class SelectDateDialog extends StatefulWidget {
  const SelectDateDialog({Key? key}) : super(key: key);

  @override
  State<SelectDateDialog> createState() => _SelectDateDialogState();
}

class _SelectDateDialogState extends State<SelectDateDialog> {
  bool show = true;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Select a date for your search query',
            style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins',
                fontSize: 26),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 40),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
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
                  Navigator.pop(context, selectDay);
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
          ),
        ],
      ),
    );
  }
}
