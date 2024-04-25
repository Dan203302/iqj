import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month; // Формат календаря
  DateTime selectedDay = DateTime.now(); // Выбранный день
  DateTime focusedDay = DateTime.now(); // День, на который сделан фокус

  @override
  Widget build(BuildContext context) {
    return content();
  }

  Widget content() {
    return TableCalendar(
      rowHeight: 47, // Высота строки
      availableGestures: AvailableGestures.all, 
      focusedDay: selectedDay, // День, на который сделан фокус
      firstDay: DateTime(2023, 1, 1), // Первый день
      lastDay: DateTime(2030, 1, 1), // Последний день
      calendarFormat: format, // Формат календаря
      onFormatChanged: (CalendarFormat _format) {
        setState(() {
          format = _format;
        });
      }, // Изменение формата календаря
      startingDayOfWeek: StartingDayOfWeek.monday, // Первый день недели
      daysOfWeekVisible: true, // Видимость дней недели
      onDaySelected: (DateTime selectDay, DateTime focusDay) {
        setState(() {
          selectedDay = selectDay;
          focusedDay = focusDay;
        });
        print(focusedDay);
      }, // Выбор дня
      selectedDayPredicate: (DateTime date) {
        return isSameDay(selectedDay, date);
      }, // Проверка, является ли день выбранным
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true, // Выделение сегодняшнего дня
        defaultDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFEFAC00).withOpacity(0.56),
        ), // Декорация дня по умолчанию
        selectedDecoration: BoxDecoration(
          color: const Color(0xFFEFAC00).withOpacity(0.17),
          shape: BoxShape.circle,
        ), // Декорация выбранного дня
        selectedTextStyle: const TextStyle(color: Colors.white), // Стиль текста выбранного дня
        todayDecoration: const BoxDecoration(
          color: Color(0xFFEF9800),
          shape: BoxShape.circle,
        ), // Декорация сегодняшнего дня
        defaultTextStyle: const TextStyle(color: Colors.white), // Стиль текста дня по умолчанию
        weekendTextStyle: const TextStyle(color: Colors.white), // Стиль текста выходного дня
        weekendDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF545448) : const Color(0xFFD1D1D1),
        ), // Декорация выходного дня
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: true,
        formatButtonShowsNext: false,
        formatButtonDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(5.0),
        ),
        formatButtonTextStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class CustomCalendarBuilder extends CalendarBuilders {
  Widget buildDefaultCell({
    required BuildContext context,
    required DateTime date,
    required List<dynamic> events,
    bool isSelected = false,
    bool isToday = false,
    bool isInSelectedRange = false,
    bool isInRange = false,
    bool isInCurrentMonth = true,
  }) {
    final defaultDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: const Color(0xFFEFAC00).withOpacity(0.56),
    );

    final selectedDecoration = BoxDecoration(
      color: const Color(0xFFEFAC00).withOpacity(0.17),
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFEFAC00).withOpacity(0.17),
          blurRadius: 5,
        )
      ]
    );

    return Container(
      constraints: const BoxConstraints(
        minWidth: 50, 
        minHeight: 50,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isSelected)
            Container(
              decoration: selectedDecoration,
            ),
          Container(
            decoration: defaultDecoration,
            child: Center(
              child: Text(
                date.day.toString(),
                style: isSelected
                    ? const TextStyle(color: Colors.white)
                    : const TextStyle(color: Colors.white),
              ),
            ),
          ),
          if (date.weekday == DateTime.saturday)
             Positioned(
              right: 0,
              bottom: 0,
              child: Icon(
                Icons.circle,
                size: 8,
                color: const Color(0xFFEFAC00).withOpacity(0.56),
              ),
            ),
        ],
      ),
    );
  }
}
