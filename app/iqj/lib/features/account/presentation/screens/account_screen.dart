import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iqj/features/account/domain/profilePicture.dart';
import 'package:iqj/features/account/domain/profileInfo.dart';
import 'package:iqj/features/account/domain/listButton.dart';
import 'package:iqj/features/account/domain/editButton.dart';
import 'package:iqj/features/account/domain/logoffButton.dart';
import 'package:iqj/main.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

void showExitDialog(BuildContext context) {
  final Widget okButton = TextButton(
    style: const ButtonStyle(
      overlayColor: MaterialStatePropertyAll(Color.fromARGB(64, 239, 172, 0)),
    ),
    child: const Text(
      "Выйти",
      style: TextStyle(
        color: Color.fromARGB(255, 239, 172, 0),
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  final Widget cancelButton = TextButton(
    style: const ButtonStyle(
      overlayColor: MaterialStatePropertyAll(Color.fromARGB(64, 239, 172, 0)),
    ),
    child: const Text(
      "Закрыть",
      style: TextStyle(
        color: Color.fromARGB(255, 193, 85, 78),
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  final AlertDialog alert = AlertDialog(
    title: const Text(
      "Выйти?",
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    content: const Text("Вы действительно желаете выйти?"),
    actions: [
      cancelButton,
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

class _AccountScreenState extends State<AccountScreen> {
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Личный кабинет",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.only(left: 15, top: 14),
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              const Text(
                "Личный кабинет",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                alignment: Alignment.center,
                child: const ProfilePicture(),
              ),
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.center,
                child: const ProfileInfo(),
              ),
              const SizedBox(height: 24),
              ListButton(),
              const SizedBox(height: 24),
              ListButton(),
              const SizedBox(height: 24),
              Row(
                children: [
                  //EditButton(),
                  //LogoffButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
