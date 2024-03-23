import 'package:flutter/material.dart';
import 'package:iqj/features/auth/presentation/screens/auth_screen.dart';
import 'package:iqj/features/homescreen/presentation/homescreen.dart';
import 'package:iqj/features/news/presentation/screens/news_loaded_list_screen.dart';
import 'package:iqj/features/welcome/presentation/welcome.dart';
import 'package:iqj/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  late bool firstLaunch = false;

  @override
  void initState() {
    _loadPreferences();
    super.initState();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(
      () {
        firstLaunch = prefs.getBool('firstLaunch') ?? true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final NewsRepository _newsRepository = NewsRepository();

    return MaterialApp(
      title: 'IQJ',
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: firstLaunch? 'welcome' : '/',
      routes: {
        '/' : (context) => const HomeScreen(),
        'welcome' : (context) => const Welcome(),
        'authorise' :(context) => const AuthScreen(),
        'newslist' : (context) => const NewsList(),
      },
    );
  }
}
