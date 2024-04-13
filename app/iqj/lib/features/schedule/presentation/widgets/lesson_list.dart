import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqj/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:iqj/features/schedule/presentation/bloc/schedule_state.dart';

class Lessons extends StatelessWidget {
  const Lessons({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoading) {
            return const CircularProgressIndicator();
          } else if (state is ScheduleLoadingFailed) {
            return const Text("Произошла ошибка при загрузке расписания: ");
          } else if (state is ScheduleLoaded) {
            return ListView.builder(
              itemCount: state.scheduleList.length,
              itemBuilder: (context, index) => Card(
                // Build your card using state.scheduleList[index]
              ),
            );
          } else {
            return const Text('Unhandled state');
          }
        },
      ),
    );
  }
}
