import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(image: AssetImage('assets/images/welcome/welcome_1.png')),
              SizedBox(
                height: 90,
              ),
              Text(
                'Добро\n пожаловать!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 210,
              ),
              FilledButton(
                onPressed: null,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Color(0xFFEFAC00)),
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.only(left: 110, right: 110, top: 20, bottom: 20),
                  ),
                ),
                child: Text(
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
