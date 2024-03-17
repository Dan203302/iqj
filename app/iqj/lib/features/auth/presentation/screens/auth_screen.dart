import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iqj/features/auth/domain/emailField.dart';
import 'package:iqj/features/auth/domain/passwordField.dart';
import 'package:iqj/main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

void showChpwdDialog(BuildContext context) {
  final Widget okButton = TextButton(
    style: const ButtonStyle(
      overlayColor: MaterialStatePropertyAll(Color.fromARGB(64, 239, 172, 0)),
    ),
    child: const Text(
      "Закрыть",
      style: TextStyle(
        color: Color.fromARGB(255, 239, 172, 0),
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  final AlertDialog alert = AlertDialog(
    title: const Text(
      "Смена пароля",
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    content: const Text("Todo"),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _LoginScreenState extends State<AuthScreen> {
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    Color boxFillColor = const Color(0xFFF6F6F6);
    final GlobalKey<FormState> _formKey = GlobalKey();

    final FocusNode _focusNodePassword = FocusNode();
    final TextEditingController _controllerEmail = TextEditingController();
    final TextEditingController _controllerPassword = TextEditingController();

    return MaterialApp(
      title: "Вход",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 72),
                const Text(
                  "Вход",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Введите почту в домене @mirea.ru",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                EmailField(),
                const SizedBox(height: 20),
                PasswordField(),
                const SizedBox(height: 20),
                Container(
                  child: Transform.translate(
                    offset: const Offset(-10, 0),
                    child: TextButton(
                      style: const ButtonStyle(
                        overlayColor: MaterialStatePropertyAll(
                            Color.fromARGB(64, 239, 172, 0)),
                        //overlayColor: MaterialStatePropertyAll(Colors.transparent),
                      ),
                      child: const Text(
                        "Забыли пароль?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 239, 172, 0),
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        showChpwdDialog(context);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        //alignment: Alignment.center,
                        backgroundColor: const Color(0xFFEFAC00),
                        fixedSize: Size(160, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const App();
                              },
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Войти",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
