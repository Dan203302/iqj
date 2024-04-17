import 'package:iqj/features/schedule/domain/lesson.dart';

// Дни состоят из пар и имеют свой порядковый номер внутри недели
abstract class Day {
  final int order; // Номер дня внутри недели
  final String date; // дата 'дд.мм.гггг'
  Day._(this.order, this.date);
}

// Рабочий день
// В теории, можно добавить массив с типами пар (лекции/практики и т.п.) для удобства использования в календаре
class WorkingDay extends Day {
  final List<Lesson?> lessons; // Список пар в этот день

  WorkingDay({
    required this.lessons,
    required int order,
    required String date,
  }) : super._(order, date);
}

// Выходной день (именно выходной, а не рабочий без пар!)
class DayOff extends Day {
  DayOff(super.order, super.date) : super._();
}
