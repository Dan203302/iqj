import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:iqj/features/news/domain/news.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iqj/features/news/data/bookmarks.dart';

class SpecialNewsCard extends StatefulWidget {
  final News news;
  bool bookmarked;
  final Function onBookmarkToggle;

  SpecialNewsCard({super.key, required this.news, required this.bookmarked, required this.onBookmarkToggle});

  @override
  State<StatefulWidget> createState() => _NewsCard();
}

class _NewsCard extends State<SpecialNewsCard> {

  bool flag_close = false;

  void announce_close() {
    setState(() {
      flag_close = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.only(
                  top: 12, left: 12, right: 12, bottom: 12),
              padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primaryContainer,
                // В дизайне же нет рамки вроде не было рамки 🤨
                // border: Border.all(
                //   color: const Color.fromARGB(255, 255, 166, 0),
                // ),
                // boxShadow: const [
                //   BoxShadow(
                //     blurRadius: 2,
                //     color: Color.fromARGB(255, 239, 172, 0),
                //     spreadRadius: 1,
                //   ),
                // ],
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
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 255, 166, 0),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              announce_close();
                            });
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
}
