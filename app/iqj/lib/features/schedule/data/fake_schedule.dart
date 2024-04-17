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
        date: '01.01.2024',
      ),
      DayOff(2, '02.01.2024'),
      DayOff(3, '03.01.2024'),
      DayOff(4, '04.01.2024'),
      DayOff(5, '05.01.2024'),
      DayOff(6, '06.01.2024'),
      DayOff(7, '07.01.2024'),
    ],
  ),
  Week(
    order: 2,
    days: [
      DayOff(2, '08.01.2024'),
      DayOff(3, '09.01.2024'),
      DayOff(4, '10.01.2024'),
      DayOff(5, '11.01.2024'),
      DayOff(6, '12.01.2024'),
      DayOff(7, '13.01.2024'),
    ],
  ),
  Week(
    order: 3,
    days: [
      DayOff(2, '14.01.2024'),
      DayOff(3, '15.01.2024'),
      DayOff(4, '16.01.2024'),
      DayOff(5, '17.01.2024'),
      DayOff(6, '18.01.2024'),
      DayOff(7, '19.01.2024'),
    ],
  ),
  Week(
    order: 4,
    days: [
      DayOff(2, '20.01.2024'),
      DayOff(3, '21.01.2024'),
      DayOff(4, '22.01.2024'),
      DayOff(5, '23.01.2024'),
      DayOff(6, '24.01.2024'),
      DayOff(7, '25.01.2024'),
    ],
  ),
  Week(
    order: 5,
    days: [
      DayOff(2, '26.01.2024'),
      DayOff(3, '27.01.2024'),
      DayOff(4, '28.01.2024'),
      DayOff(5, '29.01.2024'),
      DayOff(6, '30.01.2024'),
      DayOff(7, '31.01.2024'),
    ],
  ),
  Week(
    order: 6,
    days: [
      DayOff(2, '01.02.2024'),
      DayOff(3, '02.02.2024'),
      DayOff(4, '03.02.2024'),
      DayOff(5, '04.02.2024'),
      DayOff(6, '05.02.2024'),
      DayOff(7, '06.02.2024'),
    ],
  ),
  Week(
    order: 7,
    days: [
      DayOff(2, '07.02.2024'),
      DayOff(3, '08.02.2024'),
      DayOff(4, '09.02.2024'),
      DayOff(5, '10.02.2024'),
      DayOff(6, '11.02.2024'),
      DayOff(7, '12.02.2024'),
    ],
  ),
  Week(
    order: 8,
    days: [
      DayOff(2, '13.02.2024'),
      DayOff(3, '14.02.2024'),
      DayOff(4, '15.02.2024'),
      DayOff(5, '16.02.2024'),
      DayOff(6, '17.02.2024'),
      DayOff(7, '18.02.2024'),
    ],
  ),
  Week(
    order: 9,
    days: [
      DayOff(2, '19.02.2024'),
      DayOff(3, '20.02.2024'),
      DayOff(4, '21.02.2024'),
      DayOff(5, '22.02.2024'),
      DayOff(6, '23.02.2024'),
      DayOff(7, '24.02.2024'),
    ],
  ),
];
