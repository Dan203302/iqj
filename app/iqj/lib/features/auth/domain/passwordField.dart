import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _ishidden = true;
  Color boxFillColor = const Color(0xFFF6F6F6);

  void _toggleVisibility() {
    setState(
      () {
        _ishidden = !_ishidden;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: _ishidden,
        keyboardType: TextInputType.visiblePassword,
        cursorColor: const Color.fromARGB(255, 239, 172, 0),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: boxFillColor,
          label: Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              "Пароль",
              style: TextStyle(
                color: Color(0xFFBDBDBD),
                fontSize: 20,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFE8E8E8),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFE8E8E8),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFDC0000),
              width: 2,
            ),
          ),
          errorStyle: const TextStyle(
            color: Color(0xFFDC0000),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 239, 172, 0),
              width: 2,
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(_ishidden
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined),
            onPressed: () {
              setState(
                () {
                  _ishidden = !_ishidden;
                },
              );
            },
          ),
        ),
        onChanged: (value) {
          boxFillColor = const Color(0xFFF6F6F6);
        },
        validator: (value) {
          // TODO сделать подсветку ошибок
          if (value == null) {
            boxFillColor = Color(0xFFFFE5E5);
            return 'Введите пароль';
          } else if (value.length < 3) {
            boxFillColor = Color(0xFFFFE5E5);
            return 'Пароль должен содержать минимум 3 символа.';
          }
        },
      ),
    );
  }
}
