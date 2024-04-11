import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GeneralNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Создать',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Добавить фото',
            textAlign: TextAlign.left,
            style: 
            TextStyle(
              fontFamily: 'Inter',
              fontSize: 16, color: Colors.white,
              fontWeight: FontWeight.w700,
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //icon: SvgPicture.asset('assets/icons/news/bookmark2.svg'),
                  //SvgPicture.asset('assets/icons/news/images_add.svg'), // Иконка или изображение
                  Icon(Icons.image, size: 39),
                  SizedBox(width: 8), // Расстояние между изображением и текстом
                  Text('Загрузить изображение',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.6),
                    ),

                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              three_but(),
              three_but(),
              three_but(),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10,top: 8),
            child: Text('Заголовок',
            textAlign: TextAlign.left,
            style: 
            TextStyle(
              fontFamily: 'Inter',
              fontSize: 16, color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 5,right: 5),
            decoration: BoxDecoration(
              color: Color.fromRGBO(44, 45, 47, 1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1),
            ),
            child: const TextField(
              decoration: InputDecoration(
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(20.0),
                // ),
                //icon: Icon(Icons.search),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)
                ),
                hintText: "  Заголовок",
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  height: 1.5,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10,top: 25),
            child: Text('Редактор',
            textAlign: TextAlign.left,
            style: 
            TextStyle(
              fontFamily: 'Inter',
              fontSize: 16, color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            ),
          ),
          Container(
            height: 90,
            margin: EdgeInsets.only(top: 10, left: 5,right: 5),
            decoration: BoxDecoration(
              color: Color.fromRGBO(44, 45, 47, 1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1),
            ),
            child: const TextField(
              decoration: InputDecoration(
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(20.0),
                // ),
                //icon: Icon(Icons.search),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)
                ),
                hintText: "  Заголовок",
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  height: 1.5,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}   




Widget three_but(){
  return Container(
            width: 120,
            height: 99,
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //icon: SvgPicture.asset('assets/icons/news/bookmark2.svg'),
                  // SvgPicture.asset(
                  //   'assets/icons/news/plus.svg',
                  //   width: 32,
                  //   height: 32,
                  // ), // Иконка или изображение
                  Icon(Icons.image, size: 39),
                  Icon(Icons.add,size: 16),
                  SizedBox(width: 8), // Расстояние между изображением и текстом
                  // Text('Загрузить изображение',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     color: Color.fromRGBO(255, 255, 255, 0.6),
                  //   ),

                  // ),
                ],
              ),
            ),
          );
}