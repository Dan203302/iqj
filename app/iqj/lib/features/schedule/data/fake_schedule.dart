import 'package:iqj/features/schedule/domain/day.dart';
import 'package:iqj/features/schedule/domain/lesson.dart';
import 'package:iqj/features/schedule/domain/week.dart';

// Массив, служащий заглушкой для расписания.
// Не стесняйтесь изменять по мере надобности.
/*
В список дней так же можно добавлять и объекты
класса WorkingDay, т.к. он - дочерний для класса day
*/

Future<List<Week>> getSchedule() async {
  return schedule;
}

final List<Week> schedule = [
  Week(
    order: 1,
    days: [
      WorkingDay(
        lessons: [
          Lesson(
            name: "Физика",
            type: "Лекция",
            classroom: "A-63 (МП-1)",
            groups: [
              "ЭФБО-01-23",
              "ЭФБО-02-23",
              "ЭФБО-03-23",
              "ЭФБО-04-23",
              "ЭФБО-05-23",
            ],
            professor: "Я не помню",
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
        order: 1,
      ),
      DayOff(2),
      DayOff(3),
      DayOff(4),
      DayOff(5),
      DayOff(6),
      DayOff(7),
    ],
  ),
  Week(
    order: 2,
    days: [
      DayOff(2),
      DayOff(3),
      DayOff(4),
      DayOff(5),
      DayOff(6),
      DayOff(7),
    ],
  ),
  Week(
    order: 3,
    days: [
      DayOff(2),
      DayOff(3),
      DayOff(4),
      DayOff(5),
      DayOff(6),
      DayOff(7),
    ],
  ),
  Week(
    order: 4,
    days: [
      DayOff(2),
      DayOff(3),
      DayOff(4),
      DayOff(5),
      DayOff(6),
      DayOff(7),
    ],
  ),
  Week(
    order: 5,
    days: [
      DayOff(2),
      DayOff(3),
      DayOff(4),
      DayOff(5),
      DayOff(6),
      DayOff(7),
    ],
  ),
  Week(
    order: 6,
    days: [
      DayOff(2),
      DayOff(3),
      DayOff(4),
      DayOff(5),
      DayOff(6),
      DayOff(7),
    ],
  ),
  Week(
    order: 7,
    days: [
      DayOff(2),
      DayOff(3),
      DayOff(4),
      DayOff(5),
      DayOff(6),
      DayOff(7),
    ],
  ),
  Week(
    order: 8,
    days: [
      DayOff(2),
      DayOff(3),
      DayOff(4),
      DayOff(5),
      DayOff(6),
      DayOff(7),
    ],
  ),
  Week(
    order: 9,
    days: [
      DayOff(2),
      DayOff(3),
      DayOff(4),
      DayOff(5),
      DayOff(6),
      DayOff(7),
    ],
  ),
];
