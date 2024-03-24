import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildAnnouncement(){
  return Container(
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
                        const Expanded(
                          child: Text(
                            'С 35 нояктября по 64 апремая в корпусе В-78 будет закрыт главный вход. ',
                            softWrap: true,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 255, 166, 0),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                          },
                          icon: SvgPicture.asset('assets/icons/news/close.svg'),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
}