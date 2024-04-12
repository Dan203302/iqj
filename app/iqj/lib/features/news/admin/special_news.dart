import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iqj/features/news/admin/news_add_button.dart';
import 'package:iqj/features/news/presentation/screens/search/body_for_tags/body_tags.dart';

class SpecialNews extends StatelessWidget {
  SpecialNews({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    final FocusNode _focusNode = FocusNode();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Создать',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12, top: 8),
            child: Text(
              'Предпросмотр',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.only(left: 12, right: 12),
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromARGB(255, 250, 228, 171),
              border: Border.all(
                color: const Color.fromARGB(255, 255, 166, 0),
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  color: Color.fromARGB(255, 239, 172, 0),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              child: SvgPicture.asset(
                                'assets/icons/schedule/warning.svg',
                                semanticsLabel: 'warning',
                                height: 24,
                                width: 24,
                                allowDrawingOutsideViewBox: true,
                                // color: const Color.fromARGB(255, 239, 172, 0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${_controller.text}',
                                softWrap: true,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 255, 166, 0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 25),
            child: Text(
              'Редактор',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            height: 120,
            margin:
                const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 30),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(44, 45, 47, 1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1),
            ),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(20.0),
                // ),
                //icon: Icon(Icons.search),
                //enabledBorder: UnderlineInputBorder(
                //    borderSide: BorderSide(color: Colors.transparent)),
                hintText: "  Новость...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  height: 1.5,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                ),
              ),
              onChanged: (text) {},
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 25),
            child: Text(
              'Срок',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              color: Color.fromRGBO(44, 45, 47, 1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "C: ",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(20.0),
                      // ),
                      //icon: Icon(Icons.search),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "  01.03.24",
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
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              color: Color.fromRGBO(44, 45, 47, 1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "По: ",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(20.0),
                      // ),
                      //icon: Icon(Icons.search),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "  01.03.24",
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 5, left: 8),
                  height: 35,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(50),
                    borderRadius: BorderRadius.circular(24.0),
                    color: const Color.fromRGBO(44, 45, 47, 1),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "1 день",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  height: 35,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(50),
                    borderRadius: BorderRadius.circular(24.0),
                    color: const Color.fromRGBO(44, 45, 47, 1),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "3 дня",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  height: 35,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(50),
                    borderRadius: BorderRadius.circular(24.0),
                    color: const Color.fromRGBO(44, 45, 47, 1),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Неделя",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 25),
            child: Text(
              "Эта новость будет показана всем преподавателям.",
              textAlign: TextAlign.center,
            ),
          ),
          news_add_button(),
        ],
      ),
    );
  }
}

Widget three_but() {
  return Container(
    width: 120,
    height: 99,
    //color: Color.fromRGBO(44, 45, 47, 1),
    //color: Colors.blue,
    margin: EdgeInsets.only(top: 10, left: 5, right: 5),
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
        backgroundColor: MaterialStateProperty.all(
            Color.fromRGBO(44, 45, 47, 1)), // Серый цвет фона кнопки
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
          Icon(Icons.add, size: 16),
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
