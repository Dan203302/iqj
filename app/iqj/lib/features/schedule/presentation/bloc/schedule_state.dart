// Абстрактный класс для состояний, будет расширен по потребности
import 'package:iqj/features/schedule/domain/week.dart';

abstract class ScheduleState {
  ScheduleState();
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoadingFailed extends ScheduleState {
  final Object? exception;
  ScheduleLoadingFailed(this.exception);
}

class ScheduleLoaded extends ScheduleState {
  final List<Week> scheduleList;
  ScheduleLoaded(this.scheduleList);
}
