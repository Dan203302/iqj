// Абстрактный класс для событий, будет расширен по потребности
abstract class ScheduleEvent {
  const ScheduleEvent();
}

class LoadScheduleEvent extends ScheduleEvent {}

class SelectScheduleEvent extends ScheduleEvent {}
