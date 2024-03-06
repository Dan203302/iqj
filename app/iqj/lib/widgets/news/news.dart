// Основной виджет - News

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iqj/widgets/news/newsListGenerator.dart';
import 'package:shimmer/shimmer.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late Future<List<NewsArticle>> newsList;

  @override
  void initState() {
    super.initState();
    newsList = getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 72,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Новости',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    //TODO
                  },
                  icon: Icon(Icons.bookmarks_outlined),
                ),
                const SizedBox(
                  width: 6,
                ),
                IconButton(
                  onPressed: () {
                    showFilterDialog(context);
                  },
                  icon: const Icon(Icons.filter_alt_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
      body: //newsCard(),
      FutureBuilder(
        future: newsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return waitingForNewsAnim();
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
              //child: Text("Ошибка загрузки.")
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Нет новостей!'),
            );
          }
          return buildNews(snapshot.data!);
        },
      ),
    );
  }
}

// Important news alert
Widget importantNews() {
  return Container(
    margin: const EdgeInsets.only(top: 12),
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
              SvgPicture.asset(
                'assets/icons/schedule/warning.svg',
                semanticsLabel: 'warning',
                height: 24,
                width: 24,
                allowDrawingOutsideViewBox: true,
                // color: const Color.fromARGB(255, 239, 172, 0),
              ),
              const Expanded(
                child: Text(
                  'С 25 мая по 28 июня будет проводиться что-то очень важное.',
                  softWrap: true,
                  style: TextStyle(
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
  );
}


void showFilterDialog(BuildContext context) {
  final Widget okButton = TextButton(
    style: const ButtonStyle(
      overlayColor: MaterialStatePropertyAll(Color.fromARGB(64, 239, 172, 0)),
    ),
    child: const Text(
      "Закрыть",
      style: TextStyle(
        color: Color.fromARGB(255, 239, 172, 0),
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  final AlertDialog alert = AlertDialog(
    title: const Text(
      "Фильтры",
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    content: const Text("Todo"),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget waitingForNewsAnim() {
  return Shimmer.fromColors(
    baseColor: const Color(0xFF898989),
    highlightColor: Colors.white,
    child: const Card(
    ),
  );
}
