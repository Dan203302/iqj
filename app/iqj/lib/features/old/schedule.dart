import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iqj/features/news/presentation/screens/news_loaded_list.dart';
import 'package:iqj/features/news/presentation/screens/news_screen.dart';
// import 'package:http/http.dart' as http;

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

void showFilterDialog(BuildContext context) { 
              final Widget okButton = TextButton(
                style: const ButtonStyle(
                  overlayColor: MaterialStatePropertyAll(Color.fromARGB(64, 239, 172, 0)),
                ),
                child: const Text(
                  "Закрыть",
                  style: TextStyle(
                    color: Color.fromARGB(255, 239, 172, 0),
                  ),),
                onPressed: () { 
                  Navigator.of(context).pop();
                },
              );

              final AlertDialog alert = AlertDialog(
                title: const Text("Фильтры",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                ),
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                content: const Text("Todo"),
                actions: [
                  okButton,
                ],
              );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
}


class _ScheduleState extends State<Schedule> {
  late Future<List<DaySchedule>> dayScheduleList;

  @override
  void initState() {
    super.initState();
    // Отключаем реальный парсер и используем заглушку
    // dayScheduleList = fetchSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        toolbarHeight: 72,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Расписание',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    showFilterDialog(context);
                  },
                  icon: SvgPicture.asset('assets/icons/news/filter.svg'),
                ),
              ],
            ),
          ),
        ],
      ),

      // TODO заменить на генератор блоков новостей
      body: ListView(
        padding: const EdgeInsets.only(left: 12, right: 12),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.only(left: 12, right: 12),
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primaryContainer,
              border: Border.all(
                color: const Color.fromARGB(255, 255, 166, 0),
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  color: Color.fromARGB(255, 239, 172, 0),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(  
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: SvgPicture.asset(
                        'assets/icons/schedule/warning.svg',
                          semanticsLabel: 'warning',
                          height: 24,
                          width: 24,
                          allowDrawingOutsideViewBox: true,
                          // color: const Color.fromARGB(255, 239, 172, 0),
                        ),
                      ),
                        const Expanded(
                          child: Text(
                            'С 25 мая по 28 июня будет проводиться что-то очень важное.',
                            softWrap: true,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 255, 166, 0),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black12,
            ),
            child: const Text(
              'Пара 1',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black12,
            ),
            child: const Text(
              'Пара 2',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black12,
            ),
            child: const Text(
              'Пара 3',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black12,
            ),
            child: const Text(
              'Пара 4 (Пустая)',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black12,
            ),
            child: const Text(
              'Пара 5',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Заглушка для данных расписания
Future<List<DaySchedule>> fetchSchedule() async {
  const dummyData = '''
    [
      {"name": "Понедельник", "groups": "Группа 1"},
      {"name": "Вторник", "groups": "Группа 2"},
      {"name": "Среда", "groups": "Группа 3"},
      {"name": "Четверг", "groups": "Группа 4"},
      {"name": "Пятница", "groups": "Группа 5"}
    ]
  ''';
  return compute(parseSchedule, dummyData);
}

List<DaySchedule> parseSchedule(String body) {
  final parsed = (jsonDecode(body) as List).cast<Map<String, dynamic>>();

  return parsed.map<DaySchedule>((json) => DaySchedule.fromJson(json)).toList();
}

class DaySchedule {
  final String name;
  final String groups;
  DaySchedule({required this.name, required this.groups});

  factory DaySchedule.fromJson(Map<String, dynamic> json) {
    return DaySchedule(
      name: json['name'] as String,
      groups: json['groups'] as String,
    );
  }
}
