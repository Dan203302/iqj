import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqj/features/news/data/news_repository.dart';
import 'package:iqj/features/news/presentation/bloc/news_bloc.dart';
import 'package:iqj/features/old/news/news.dart';
import 'package:iqj/features/old/schedule.dart';
import 'package:iqj/features/auth/presentation/screens/auth_screen.dart';
import 'package:iqj/features/welcome/presentation/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Велкам -> логин -> приложение
void main() => runApp(const App());
//void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var _currentPage = 0;
  late bool notAFirstLaunch;

  final _pages = <Widget>[
    const Schedule(),
    const Text('Здесь будет личный кабинет'),
    const Text('Здесь будут чаты'),
    BlocProvider(
      create: (context) => NewsBloc(NewsRepository()),
      child: const News(),
    ),
    const Text('Здесь будут сервисы'),
  ];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(
      () {
        notAFirstLaunch = prefs.getBool('notAFirstLaunch') ?? false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final NewsRepository _newsRepository = NewsRepository();

    return MaterialApp(
      title: 'IQJ',
      debugShowCheckedModeBanner: false,
      initialRoute: notAFirstLaunch? '/' : 'welcome',
      routes: {
        '/': (context) => HomeScreen(),
        'welcome': (context) => const Welcome(),
      },
    );
  }

  Scaffold HomeScreen() {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_currentPage),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Расписание',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'ЛК',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Чаты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Новости',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Сервисы',
          ),
        ],
        currentIndex: _currentPage,
        fixedColor: const Color(0xFFEFAC00),
        onTap: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}
