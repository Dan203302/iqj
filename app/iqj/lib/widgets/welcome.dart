import 'package:flutter/material.dart';
import 'package:iqj/widgets/welcomeSecondScreen.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Image(
                image: AssetImage('assets/images/welcome/welcome_1.png'),
              ),
              const SizedBox(
                height: 90,
              ),
              const Text(
                'Добро\n пожаловать!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 210,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeSecondScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFFEFAC00)),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.only(
                      left: 110,
                      right: 110,
                      top: 20,
                      bottom: 20,
                    ),
                  ),
                ),
                child: const Text(
                  'Далее',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
