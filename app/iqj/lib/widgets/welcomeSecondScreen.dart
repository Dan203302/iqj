import 'package:flutter/material.dart';
import 'package:iqj/widgets/welcome.dart';

class WelcomeSecondScreen extends StatelessWidget {
  const WelcomeSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'IQJ - инновационное приложение, разработанное специально для преподавателей университета МИРЭА',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(
              height: 54,
            ),
            const Image(
              image: AssetImage('assets/images/welcome/welcome_2.png'),
            ),
            const SizedBox(
              height: 100,
            ),

            // Группа кнопок (назад и далее)
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                // Кнопка "Назад"
                ElevatedButton(
                  onPressed: () {
                    // Обработчик нажатия для кнопки "Назад"
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Welcome(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFEFAC00),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.only(
                        left: 36,
                        right: 36,
                        top: 20,
                        bottom: 20,
                      ),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 26,
                      ),
                    ],
                  ),
                ),

                // Кнопка "Далее"
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Обработчик нажатия для кнопки "Далее"
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFEFAC00)),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.only(
                          left: 70,
                          right: 70,
                          top: 20,
                          bottom: 20,
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Далее',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
