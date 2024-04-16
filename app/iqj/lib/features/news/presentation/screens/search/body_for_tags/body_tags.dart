import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget create_body_tags() {
  return Container(
    height: 220,
    width: 325,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 15),
          child: const TextField(
            decoration: InputDecoration(
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(20.0),
              // ),
              //icon: Icon(Icons.search),
              hintText: "Поиск...",
              hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                height: 1.5,
              ),
              icon: Icon(Icons.search),
            ),
          ),
        ),
        Container(
          //padding: const EdgeInsets.only(bottom: 5),
          height: 150,
          width: 275,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top:
                  BorderSide(color: Color.fromRGBO(202, 196, 208, 1), width: 2),
              bottom:
                  BorderSide(color: Color.fromRGBO(202, 196, 208, 1), width: 2),
            ),
          ),
          //padding: EdgeInsets.all(8),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Популярные',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget create_body_tags_black() {
  return Container(
    height: 220,
    width: 325,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 15),
          child: const TextField(
            decoration: InputDecoration(
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(20.0),
              // ),
              //icon: Icon(Icons.search),
              hintText: "Поиск...",
              hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                height: 1.5,
              ),
              icon: Icon(Icons.search),
            ),
          ),
        ),
        Container(
          //padding: const EdgeInsets.only(bottom: 5),
          height: 150,
          width: 275,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(44, 45, 47, 1),
            border: Border(
              top:
                  BorderSide(color: Color.fromRGBO(232, 232, 232, 1), width: 2),
              bottom:
                  BorderSide(color: Color.fromRGBO(232, 232, 232, 1), width: 2),
            ),
          ),
          //padding: EdgeInsets.all(8),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Популярные',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),
      ],
    ),
  );
}
