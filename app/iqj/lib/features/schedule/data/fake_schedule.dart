import 'package:iqj/features/schedule/domain/day.dart';
import 'package:iqj/features/schedule/domain/lesson.dart';

// Массив, служащий заглушкой для расписания.
// Не стесняйтесь изменять по мере надобности.
/*
В список так же можно (и нужно) добавлять и объекты
класса WorkingDay, т.к. он - дочерний для класса day
*/

Future<List<Day>> getSchedule() async {
  return schedule;
}

final List<Day> schedule = [
  WorkingDay(
    date: DateTime(2024, 1, 1),
    lessons: [
      Lesson(
        name: "Физика",
        type: "Лекция",
        classroom: "A-15 (В-78)",
        groups: [
          "ЭФБО-01-23",
          "ЭФБО-02-23",
          "ЭФБО-03-23",
          "ЭФБО-04-23",
          "ЭФБО-05-23",
        ],
        professor: "Сафронов А. А.",
      ),
      Lesson(
        name: 'Физика',
        type: 'Практика',
        classroom: 'А-107-1 (В-78)',
        groups: [
          'ЭФБО-14-88',
        ],
        professor: 'Кто-то',
      ),
      Lesson(
        name: 'Линейная алгебра и аналитическая геометрия',
        type: 'Практика',
        classroom: 'А-107-1 (В-78)',
        groups: [
          'ЭФБО-14-88',
        ],
        professor: 'Кто-то',
      ),
      null,
      null,
      null,
    ],
  ),
  DayOff(DateTime(2024, 1, 2)),
  DayOff(DateTime(2024, 1, 3)),
  DayOff(DateTime(2024, 1, 4)),
  DayOff(DateTime(2024, 1, 5)),
  DayOff(DateTime(2024, 1, 6)),
  DayOff(DateTime(2024, 1, 7)),
  DayOff(DateTime(2024, 1, 8)),
  DayOff(DateTime(2024, 1, 9)),
  DayOff(DateTime(2024, 1, 10)),
  DayOff(DateTime(2024, 1, 11)),
];
