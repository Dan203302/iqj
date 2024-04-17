import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';


class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: content(),
    );
  }
  Widget content(){
    return Column(
      children: [
        Container(
          child: TableCalendar(
            //locale: "rus",
            rowHeight: 47,
            headerStyle: HeaderStyle(formatButtonVisible: true),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            focusedDay: today,
            firstDay: DateTime(2023, 1, 1),
            lastDay: DateTime(2030, 1, 1),
            onDaySelected: _onDaySelected,

          ),
        ),
      ],
    );
  }
}