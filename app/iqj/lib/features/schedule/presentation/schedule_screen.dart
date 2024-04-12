import 'package:flutter/material.dart';
import 'package:iqj/features/schedule/presentation/calendar.dart';
import 'package:iqj/features/schedule/presentation/classes.dart';

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
          Classes(),
        ]
      ),
    );
  }
}
