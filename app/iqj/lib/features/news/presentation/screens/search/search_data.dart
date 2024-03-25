import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iqj/features/news/presentation/screens/search/body_for_data/body.dart';

void searchdata(BuildContext context) { 
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
                title: const Text("Дата",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                content: create_body_data(),
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