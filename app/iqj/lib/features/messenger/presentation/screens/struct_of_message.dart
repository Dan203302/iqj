
import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:flutter/material.dart';

// class Message extends StatelessWidget {
//   final String text;
//   final bool who;

//   const Message({required this.text, required this.who});

//   @override
//   Widget build(BuildContext context) {
//     final Color backgroundColor = who ? Colors.grey : Color.fromRGBO(158, 148, 2, 0.965);
//     final AlignmentGeometry alignment = who ? Alignment.centerRight : Alignment.centerLeft;

//     return Container(
//       margin: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
//       padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
//       alignment: alignment,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: backgroundColor,
//       ),
//       child: Text(text),
//     );
//   }

class ReceiverMessage extends StatelessWidget {
  final String url;
  final String message;
  //final String _receiver;

  const ReceiverMessage({required MainAxisAlignment mainAxisAlignment, required this.message, required this.url,});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topLeft,
      widthFactor: 0.75,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildThumbnailImage(url),
                    Flexible( // Обернуть DecoratedBox в Flexible
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(56, 56, 56, 1), // Исправлено значение альфа-канала на 1
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                            bottomLeft: Radius.circular(4),
                          ),
                        ),
                        position: DecorationPosition.background,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Выравнивание текста по левому краю
                            children: [
                              Text(
                                message,
                                softWrap: true,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Align(
                            alignment: Alignment.bottomRight, // Выравниваем текст "14:00" по нижнему правому углу
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4), // Отступ сверху для текста "14:00"
                              child: Text(
                                "14:00",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}







Widget _buildThumbnailImage(String image_url) {
    try {
      return Container(
        padding: EdgeInsets.only(right: 7),
        child: SizedBox(
          width: 33,
          height: 33,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.network(
              image_url,
              fit: BoxFit.fill,
              height: 200,
              errorBuilder: (
                BuildContext context,
                Object exception,
                StackTrace? stackTrace,
              ) {
                return CircleAvatar(
                  radius: 6,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: const Text('A'),
                );
              },
            ),
          ),
        ),
      );
    } catch (e) {
      return Container();
    }
  }
