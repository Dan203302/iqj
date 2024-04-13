import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqj/features/schedule/data/fake_schedule.dart'; // Заглушка!!!
import 'package:iqj/features/schedule/domain/day.dart';
import 'package:iqj/features/schedule/domain/week.dart';
import 'package:iqj/features/schedule/presentation/bloc/schedule_event.dart';
import 'package:iqj/features/schedule/presentation/bloc/schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  Day? _activeDay;

  ScheduleBloc() : super(ScheduleInitial()) {
    on<LoadSchedule>((_, emit) async {
      try {
        if (state is! ScheduleLoading) {
          emit(ScheduleLoading());
        }
        final List<Week> scheduleList = await getSchedule();
        emit(ScheduleLoaded(scheduleList: scheduleList, activeDay: _activeDay));
      } catch (e) {
        emit(ScheduleLoadingFailed(except: e));
      }
    });
    on<SelectDay>(
      (event, emit) async {},
    );
  }
}