import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void searh_tags(BuildContext context) { 
final Widget okButton = TextButton(
                style: const ButtonStyle(
                  overlayColor: MaterialStatePropertyAll(Color.fromARGB(64, 239, 172, 0)),
                ),
                child: const Text(
                  "Отмена",
                  style: TextStyle(
                    color: Color.fromARGB(255, 239, 172, 0),
                  ),),
                onPressed: () { 
                  Navigator.of(context).pop();
                },
              );
              final Widget searchButton= TextButton(
                style: const ButtonStyle(
                  overlayColor: MaterialStatePropertyAll(Color.fromARGB(64, 239, 172, 0)),
                ),
                child: const Text(
                  "Поиск",
                  style: TextStyle(
                    color: Color.fromARGB(255, 239, 172, 0),
                  ),),
                onPressed: () { 
                  Navigator.of(context).pop();
                },
              );

              final AlertDialog alert = AlertDialog(
                title: const Text("Теги",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                ),
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                content: const Text("Todo"),
                actions: [
                  okButton,
                  searchButton,
                ],
              );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
}