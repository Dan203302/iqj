import 'package:iqj/features/schedule/domain/day.dart';

class Week {
  final int order; //Номер недели
  final List<Day> days; //Список дней в неделе (всегда 7 дней!)

  Week({required this.order, required this.days});
}
