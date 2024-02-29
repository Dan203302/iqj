// Основной виджет - News

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
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
                  ),),
                onPressed: () { 
                  Navigator.of(context).pop();
                },
              );

              final AlertDialog alert = AlertDialog(
                title: const Text("Фильтры",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )),
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
                  icon: SvgPicture.asset('assets/icons/news/bookmarks.svg'),
                ),
                const SizedBox(width: 6,),
                IconButton(
                  onPressed: () {
                    showFilterDialog(context);
                  },
                  icon: SvgPicture.asset('assets/icons/news/filter.svg'),
                ),
              ]
            ),
          ),
        ],
      ),

      body: 
          FutureBuilder(future: newsList, builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: const CircularProgressIndicator(
                    color: Color.fromARGB(255, 255, 166, 0),
                  ),
                ),
                const Text("Загружаем"),
              ],
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
            //child: Text("Ошибка загрузки.")
          );
        }
        if (!snapshot.hasData) {
          return const Text('Нет новостей!');
        }
        return buildNews(snapshot.data!);
      },),
    );
  }
}

// Запрос к api и генерация списка новостных заголовков.
Future<List<NewsArticle>> getNews() async {
  // TODO заменить API-пустышку
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));
  final List body = (json.decode(response.body) as Map<String, dynamic>)['products'] as List;
  return body.map((e) => NewsArticle.fromJson(e as Map<String, dynamic>)).toList();
}

// Important news alert
Widget importantNews(){
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
                          color: const Color.fromARGB(255, 239, 172, 0),
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

// Генератор новостной ленты.
Widget buildNews(List<NewsArticle> newsList){
  return ListView.separated(
    padding: const EdgeInsets.only(left: 16, right: 16),
    itemCount: newsList.length,
    separatorBuilder: (_, __) => const SizedBox(height: 9,),
    // Генератор новостной карточки из заголовка
    // TODO Добавить важное уведомление
    // TODO Добавить сортировку по новизне
    itemBuilder:(context, index) {
      final article = newsList[index];
      return Center(
        child: Container(
          height: 323,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), 
            border: Border.all(color: Colors.black12),
            ),
          child: Column(children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  image: DecorationImage(image: NetworkImage(article.thumbnail), fit: BoxFit.cover),
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
                            article.title.length < 18?
                            article.title : '${article.title.substring(0, 16)}...',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                              
                          },
                          icon: SvgPicture.asset('assets/icons/news/bookmark.svg'),
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
                      style: const TextStyle(
                        height: 28,
                        fontFamily: 'Iter',
                        fontSize: 16,
                        color: Color(0xFF152536),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],),
        ),
      );
    },
  );
}



// Новостной заголовок. Используется для генерации карточки с новостью в новостной ленте.
class NewsArticle {
  final String thumbnail;
  final String title;
  final String date;
  final String description;
  NewsArticle({required this.thumbnail, required this.title, required this.date, required this.description});

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
