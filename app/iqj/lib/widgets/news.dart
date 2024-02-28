import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// class NewsItem {
//   final String title;
//   final String imageURL;
//   final String content;

//   NewsItem({required this.title, required this.imageURL, required this.content});
// }

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {

  @override
  Widget build(BuildContext context) {
    
    //TODO: добавить макет карточки и генератор оной
    final newsList = [
      Placeholder(),
      SizedBox(
        height: 9,
      ),
      Placeholder(),
      SizedBox(
        height: 9,
      ),
      Placeholder(),
    ];

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
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              //TODO
            },
            icon: SvgPicture.asset('assets/icons/news/bookmarks.svg'),
          ),
          const SizedBox(width: 6,),
          IconButton(
            onPressed: () {
              //TODO
            },
            icon: SvgPicture.asset('assets/icons/news/filter.svg'),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
        children: newsList,
      ),
    );

  }

}
