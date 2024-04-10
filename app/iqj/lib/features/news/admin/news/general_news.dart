import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GeneralNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создать'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Добавить фото',
            textAlign: TextAlign.left,
            style: 
            TextStyle(
              fontSize: 16, color: Colors.black,
            ),
            ),
          ),
          Container(
            width: 350,
            height: 192,
            //color: Color.fromRGBO(44, 45, 47, 1),
            //color: Colors.blue,
            margin: EdgeInsets.only(top: 10, left: 5,right: 5),
            decoration: BoxDecoration(
              color: Color.fromRGBO(44, 45, 47, 1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1),
            ),
            child: ElevatedButton(
              onPressed: () {
                // Обработчик нажатия кнопки
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(44, 45, 47, 1)), // Серый цвет фона кнопки
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //icon: SvgPicture.asset('assets/icons/news/bookmark2.svg'),
                  //SvgPicture.asset('assets/icons/news/bookmark2.svg'), // Иконка или изображение
                  SizedBox(width: 8), // Расстояние между изображением и текстом
                  Text('Нажми меня'), // Текст кнопки
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}   