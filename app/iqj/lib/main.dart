// import 'package:flutter/material.dart';
// import 'package:iqj/widgets/welcome.dart';

// void main() {
//   const app = App();
//   return runApp(app);
// }

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Colors.white,
//         pageTransitionsTheme: const PageTransitionsTheme(
//           builders: {
//             TargetPlatform.android:
//                 FadeUpwardsPageTransitionsBuilder(), // Анимация затухания для Android
//             TargetPlatform.iOS:
//                 FadeUpwardsPageTransitionsBuilder(), // Анимация затухания для iOS
//           },
//         ),
//       ),
//       home: const Welcome(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:iqj/widgets/news.dart';
import 'package:iqj/widgets/schedule.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var _currentPage = 0;

  final _pages = <Widget>[
    const Schedule(),
    const Text('Здесь будет личный кабинет'),
    const Text('Здесь будут чаты'),
    const News(),
    const Text('Сервисы'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IQJ',
      home: Scaffold(
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
            ), // Добавлен новый элемент
          ],
          currentIndex: _currentPage,
          fixedColor: const Color(0xFFEFAC00),
          onTap: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
      ),
    );
  }
}
