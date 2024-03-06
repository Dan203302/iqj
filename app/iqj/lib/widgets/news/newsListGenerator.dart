import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

// Запрос к api и генерация списка новостных заголовков.
Future<List<NewsArticle>> getNews() async {
  // TODO заменить API-пустышку!!!
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));
  final List body =
      (json.decode(response.body) as Map<String, dynamic>)['products'] as List;
  return body
      .map((e) => NewsArticle.fromJson(e as Map<String, dynamic>))
      .toList();
}

// Новостной заголовок. Используется для генерации карточки с новостью в новостной ленте.
class NewsArticle {
  final String thumbnail;
  final String title;
  final String date;
  final String description;
  NewsArticle(
      {required this.thumbnail,
      required this.title,
      required this.date,
      required this.description});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      // ignore: avoid_dynamic_calls
      thumbnail: json['images'][0] as String,
      title: json['title'] as String,
      date: json['price'].toString(),
      description: json['description'] as String,
    );
  }
}

// Генератор новостной ленты.
Widget buildNews(List<NewsArticle> newsList) {
  return ListView.separated(
    padding: const EdgeInsets.only(left: 16, right: 16),
    itemCount: newsList.length,
    separatorBuilder: (_, __) => const SizedBox(
      height: 9,
    ),
    // Генератор новостной карточки из заголовка
    // TODO Добавить важное уведомление
    itemBuilder: (context, index) {
      final article = newsList[index];
      return Center(
        child: Container(
          height: 323,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    image: DecorationImage(
                        image: NetworkImage(article.thumbnail),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              article.title.length < 18
                                  ? article.title
                                  : '${article.title.substring(0, 16)}...',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                                'assets/icons/news/bookmark.svg'),
                          ),
                        ],
                      ),
                      Text(
                        article.date,
                        style: const TextStyle(
                          fontFamily: 'Iter',
                          fontSize: 12,
                          color: Color(0xFF828282),
                        ),
                      ),
                      Text(
                        article.description,
                        softWrap: true,
                        style: const TextStyle(
                          fontFamily: 'Iter',
                          fontSize: 16,
                          color: Color(0xFF152536),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget newsCard() {
  return Card(
    
  );
}