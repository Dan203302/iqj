import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  late Future<List<DaySchedule>> dayScheduleList;

  @override
  void initState() {
    super.initState();
    dayScheduleList = fetchSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 72,

        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Расписание', 
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          const SizedBox(width: 6,),
          IconButton(
            onPressed: () {
              //TODO
            },
            padding: const EdgeInsets.only(right: 12), // todo fix icon/highlight offset
            icon: SvgPicture.asset('assets/icons/news/filter.svg'), // Todo three dots icon here
          ),
        ],
      ),

      // TODO заменить на генератор блоков новостей
      body: ListView(
        padding: const EdgeInsets.only(left:12, right: 12),
        children:[
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 80,
            alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(255, 250, 228, 171),
                border: Border.all(
                  color: Color.fromARGB(255, 255, 166, 0),
                ),
                boxShadow: const [ 
                  BoxShadow(
                    blurRadius: 2,
                    color: Color.fromARGB(255, 239, 172, 0),
                    offset: Offset.zero,
                    spreadRadius: 1,
                  ),
                ],
              ),
            child: const Text(
              'Календарь здесь',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 255, 166, 0),
                ),
              ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 120,
            alignment: Alignment.center,
            child: const Text(
              'Пара 1',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.normal,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black12,
              ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 120,
            alignment: Alignment.center,
            child: const Text(
              'Пара 2',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.normal,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black12,
              ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 120,
            alignment: Alignment.center,
            child: const Text(
              'Пара 3',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.normal,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black12,
              ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 60,
            alignment: Alignment.center,
            child: const Text(
              'Пара 4 (Пустая)',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.normal,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black12,
              ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 120,
            alignment: Alignment.center,
            child: const Text(
              'Пара 5',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.normal,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black12,
              ),
          ),
        ],
      ),
    );
  }
}

Future<List<DaySchedule>> fetchSchedule() async {
  // TODO Временно здесь будет пустышка, которую потом нужно заменить!!
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));
  if (response.statusCode == 200){
    return compute(parseSchedule, response.body);
  }
  else {
    throw Exception('Failed to load schedule');
  }
}

List<DaySchedule> parseSchedule(String body){
  final parsed = (jsonDecode(body) as List).cast<Map<String, dynamic>>();

  return parsed.map<DaySchedule>((json) => DaySchedule.fromJson(json)).toList();
}

class DaySchedule {
  final String name;
  final String groups;
  // []String subjects;
  // []String types;
  // []int position;
  DaySchedule({required this.name, required this.groups});

  factory DaySchedule.fromJson(Map<String, dynamic> json) {
    return DaySchedule(
      name: json['name'] as String, // redo as []
      groups: json['groups'] as String, // redo as [] and add stuff
      );
  }
}