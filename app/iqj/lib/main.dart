import 'package:flutter/material.dart';
import 'package:iqj/features/account/presentation/screens/account_screen.dart';
import 'package:iqj/features/auth/presentation/screens/auth_screen.dart';
import 'package:iqj/features/homescreen/presentation/homescreen.dart';
import 'package:iqj/features/messenger/presentation/chats_loaded_screen.dart';
import 'package:iqj/features/messenger/presentation/screens/messenger_screen.dart';
import 'package:iqj/features/news/presentation/screens/news_loaded_list_screen.dart';
import 'package:iqj/features/welcome/presentation/welcome.dart';
import 'package:iqj/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iqj/features/registration/presentation/reg_screen.dart';
import 'package:iqj/features/registration/presentation/successful_reg_screen.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override 
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late bool firstLaunch = true;

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
      //initialRoute: firstLaunch ? 'welcome' : '/',
      routes: {
        '/': (context) => const HomeScreen(),
        'welcome': (context) => const Welcome(),
        'authorise': (context) => const AuthScreen(),
        'newslist': (context) => const NewsList(),
        'account': (context) => const AccountScreen(),
        'registration': (context) => const RegScreen(),
        'successreg': (context) => const SuccessReg(),
        'messenger': (context) => const MessengerScreen(),
        'chatslist': (context) => const ChatsList(),
       },
    );
  }
}
