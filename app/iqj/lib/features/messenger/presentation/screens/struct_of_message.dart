
import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String text;
  final bool who;

  const Message({required this.text, required this.who});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = who ? Colors.grey : Color.fromRGBO(158, 148, 2, 0.965);
    final AlignmentGeometry alignment = who ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      margin: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
      padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child: Text(text),
    );
  }
}


