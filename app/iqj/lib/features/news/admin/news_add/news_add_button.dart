import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget news_add_button(){
  return Container(
    width: 150,
    height: 55,
    padding: EdgeInsets.only(left: 90,right: 90),
    margin: EdgeInsets.only(top: 20),
    child: ElevatedButton(
        onPressed: () {
          // todo
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(239, 172, 0, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: Text(
          'Добавить',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
  );
}