import 'package:flutter/material.dart';
import 'package:iqj/widgets/news_detail_screen.dart';
import 'package:iqj/widgets/welcome.dart';
import 'package:iqj/widgets/news.dart';

void main() {
  const app = App();
  return runApp(app);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android:
                FadeUpwardsPageTransitionsBuilder(), // Анимация затухания для Android
            TargetPlatform.iOS:
                FadeUpwardsPageTransitionsBuilder(), // Анимация затухания для iOS
          },
        ),
      ),
      home: const Welcome(),
    );
  }
}
