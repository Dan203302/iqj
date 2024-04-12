import 'package:flutter/material.dart';
import 'package:iqj/features/account/presentation/screens/account_screen.dart';
import 'package:iqj/features/homescreen/domain/homescreen_page.dart';
import 'package:iqj/features/news/presentation/screens/news_screen.dart';
import 'package:iqj/features/schedule/presentation/schedule_screen.dart';

const pages = <HomeScreenPage>[
  HomeScreenPage(
    label: 'Новости',
    icon: Icon(Icons.newspaper),
    widget: NewsScreen(),
  ),
  HomeScreenPage(
    label: 'Рассписание',
    icon: Icon(Icons.calendar_today),
    widget: ScheduleScreen(),
  ),
  HomeScreenPage(
    label: 'Чаты',
    icon: Icon(Icons.chat_bubble),
    widget: Text('Здесь будут чаты'),
  ),
  HomeScreenPage(
    label: 'ЛК',
    icon: Icon(Icons.account_circle),
    widget: AccountScreen(),
  ),
  HomeScreenPage(
    label: 'Сервисы',
    icon: Icon(Icons.grid_view),
    widget: Text('Здесь будут сервисы'),
  ),
];
