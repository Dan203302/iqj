import 'package:flutter/material.dart';
import 'package:iqj/features/schedule/presentation/widgets/calendar.dart';
import 'package:iqj/features/schedule/presentation/widgets/lesson_list.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Расписание',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView(
        children:[
          Calendar(),
          Lessons(),
        ]
      ),
    );
  }
}
