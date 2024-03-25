import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget create_body_data(){
  return Container(
    height: 101,
    width: 275,
    decoration: const BoxDecoration(
      color: Colors.white, 
      border: Border(
        top: BorderSide(color: Color.fromRGBO(202, 196, 208, 1), width: 2),
        bottom: BorderSide(color: Color.fromRGBO(202, 196, 208, 1), width: 2),
      ),
    ),
    //padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          child: Row(
            children: [
              const Text(
                "C  ",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30),
                height: 23,
                width: 195,
                //width: 100,
                child: 
                    const TextField(
                      // todo
                    ),
                    // Image.asset('assets/icons/news/calendary.svg',
                    //   height: 16,
                    //   width: 14,
                    // ),
                ),
            ]
              ),
          ),
        Container(
          padding: const EdgeInsets.all(9),
          child: Row(
            children: [
              const Text(
                "По",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30),
                height: 23,
                width: 195,
                //width: 100,
                child: 
                    const TextField(
                      // todo
                    ),
                    // Image.asset('assets/icons/news/calendary.svg',
                    //   height: 16,
                    //   width: 14,
                    // ),
                ),
            ]
              ),
          ),
      ],
    ),
  );
}