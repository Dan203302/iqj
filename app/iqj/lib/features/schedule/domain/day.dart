import 'package:iqj/features/schedule/domain/lesson.dart';

// Дни состоят из пар и имеют свой порядковый номер внутри недели
abstract class Day {
  final int order; // Номер дня внутри недели
  Day._(this.order);
}

// Рабочий день
class WorkingDay extends Day {
  final List<Lesson?> lessons; // Список пар в этот день

  WorkingDay({
    required this.lessons,
    required int order,
  }) : super._(order);
}

// Выходной день (именно выходной, а не рабочий без пар!)
class DayOff extends Day {
  DayOff(super.order) : super._();
}
