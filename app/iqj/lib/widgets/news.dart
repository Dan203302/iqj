// Основной виджет - News

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late Future<List<NewsArticle>> newsAlbum;

  @override
  void initState() {
    super.initState();
    newsAlbum = fetchNews();
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

      // TODO заменить на генератор блоков новостей
      body: ListView(
        padding: const EdgeInsets.only(left:12, right: 12),
        children:[
          Container(
            color: Colors.black12,
            margin: const EdgeInsets.only(top: 12),
            height: 260,
          ),
          Container(
            color: Colors.black12,
            margin: const EdgeInsets.only(top: 12),
            height: 260,
          ),
          Container(
            color: Colors.black12,
            margin: const EdgeInsets.only(top: 12),
            height: 260,
          ),
          Container(
            color: Colors.black12,
            margin: const EdgeInsets.only(top: 12),
            height: 260,
          ),
        ],
      ),
    );
  }
}

Future<List<NewsArticle>> fetchNews() async {
  // TODO Временно здесь будет пустышка, которую потом нужно заменить!!
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));
  if (response.statusCode == 200){
    return compute(parseArticles, response.body);
  }
  else {
    throw Exception('Failed to load news');
  }
}

List<NewsArticle> parseArticles(String body){
  final parsed = (jsonDecode(body) as List).cast<Map<String, dynamic>>();

  return parsed.map<NewsArticle>((json) => NewsArticle.fromJson(json)).toList();
}

class NewsArticle {
  final String thumbnail;
  final String title;
  NewsArticle({required this.thumbnail, required this.title});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      thumbnail: json['image'] as String,
      title: json['name'] as String,
      );
  }
}
