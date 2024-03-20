import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Запрос к api и генерация списка новостных заголовков.
// Future<List<NewsArticle>> getNews() async {
//   // TODO заменить API-пустышку!!!
//   final response = await http.get(Uri.parse('https://dummyjson.com/products'));
//   final List body =
//       (json.decode(response.body) as Map<String, dynamic>)['products'] as List;
//   return body
//       .map((e) => NewsArticle.fromJson(e as Map<String, dynamic>))
//       .toList();
// }

class NewsSmall extends Equatable{
  final String thumbnail;
  final String title;
  final String date;
  final String description;
  const NewsSmall(
      {required this.thumbnail,
      required this.title,
      required this.date,
      required this.description,});
  
  @override
  // TODO: implement props
  List<Object?> get props => [thumbnail,title,date,description];
  
}

// Новостной заголовок. Используется для генерации карточки с новостью в новостной ленте.
class NewsArticle {
  Future<List<NewsSmall>> getNews() async {
  // TODO заменить API-пустышку!!!
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));
  final List body =
      (json.decode(response.body) as Map<String, dynamic>)['products'] as List;
  return body
      // .map((e) => NewsArticle.fromJson(e as Map<String, dynamic>))
      .map((e) {
        final json = e as Map<String,dynamic>;
        return NewsSmall(
          title: json['title'] as String,
          date: json['price'].toString(),
          description: json['description'] as String, 
          thumbnail: json['images'][0] as String,
        );
      },)
      .toList();
}

  // factory NewsArticle.fromJson(Map<String, dynamic> json) {
  //   return Article(
  //     title: json['title'] as String,
  //     date: json['price'].toString(),
  //     description: json['description'] as String, 
  //     thumbnail: json['images'][0] as String,
  //   );
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
      return newsCardMobile(article as NewsSmall);
    },
  );
}

Card newsCardMobile(NewsSmall article) {
  bool isBookmarked = false;

  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 0.5,
    color: const Color.fromARGB(255, 255, 254, 250), // Поменять цвет, когда появится в дизайне
    child: SizedBox(
      height: 323,
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: article.thumbnail,
            fit: BoxFit.cover,
            height: 192,
            width: double.infinity,
            progressIndicatorBuilder: (context, url, progress) =>
                const SizedBox(
              child: LinearProgressIndicator(
                color: Colors.black12,
              ),
            ),
            errorWidget: (context, url, error) => const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.black87),
                Text('Что-то пошло не так.', style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        article.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        isBookmarked = !isBookmarked;
                        
                      },
                      // ignore: dead_code
                      icon: isBookmarked? Icon(Icons.bookmark, color: Colors.amber[400]) : const Icon(Icons.bookmark_outline),
                    ),
                  ],
                ),
                Text(
                  article.date,
                  style: const TextStyle(color: Colors.black54, fontFamily: 'Inter', fontSize: 12),
                ),
                Text(
                  article.description,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'Iter', fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
