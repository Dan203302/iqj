// Виджет при открытии новости
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'news.dart' as news;

class NewsArticle {
  final String thumbnail;
  final String title;
  final String date;
  final String description;

  NewsArticle({required this.thumbnail, required this.title, required this.date, required this.description, });
}

class NewsDetailScreen extends StatefulWidget {
  final news.NewsArticle newsArticle;

  const NewsDetailScreen({super.key, required this.newsArticle});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1 ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
           //TODO;
          },
          icon: SvgPicture.asset('assets/icons/news/arrow.svg'),
        ),
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
      body: Stack(
        children: [
          Container(
            child: Container(
              height: height * .45,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight:  Radius.circular(30),
                ),
                child: Image.network(
                  widget.newsArticle.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            height: height * 6,
            margin: EdgeInsets.only(top: height * .4),
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration:  const BoxDecoration(
              color: Colors.white,
            ),
            child:  ListView(
              children: [
                Text(
                  widget.newsArticle.title,
                  style:  const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    color: Color(0xFF152536),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                
                SizedBox(height: height * .03,),
                Text(
                  widget.newsArticle.description,
                  style:  const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    color: Color(0xFF152536),
                    fontWeight: FontWeight.w600,
                  ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
