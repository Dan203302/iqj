import 'package:flutter/material.dart';
import 'package:iqj/main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();

    final FocusNode _focusNodePassword = FocusNode();
    final TextEditingController _controllerUsername = TextEditingController();
    final TextEditingController _controllerPassword = TextEditingController();

    bool _obscurePassword = true;

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
                const SizedBox(height: 150),
                const Text(
                  "Вход",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Введите почту в домене @mirea.ru",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerUsername,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    fillColor: Color(0xF6F6F6FF),
                    labelText: "Почта",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onEditingComplete: () => _focusNodePassword.requestFocus(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Введите адрес почты.";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerPassword,
                  focusNode: _focusNodePassword,
                  obscureText: _obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    fillColor: Color(0xF6F6F6FF),
                    labelText: "Пароль",
                    suffixIcon: IconButton(
                        padding: EdgeInsets.only(right: 10),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: _obscurePassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Введите пароль.";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 30),
                const Text(
                  "Забыли пароль?",
                  style: TextStyle(
                    color: Color(0xFFEFAC00),
                    fontFamily: 'Inter',
                    fontSize: 20,
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
                        fixedSize: Size(200, 80),
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
                          fontWeight: FontWeight.w900,
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
