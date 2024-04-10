import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iqj/features/news/domain/news.dart';

Future<List<News>> getNews() async {
  final response = await http.get(
    Uri(
      scheme: 'https',
      host: 'mireaiqj.ru',
      path: '/news',
      queryParameters: {'offset': 0, 'count': 15},
    ),
  );
  //TODO сделать offset динамически изменяемым, чтоб получать следующие новости при страницы
  final List body =
      (json.decode(response.body) as Map<String, dynamic>)['products'] as List;
  return body.map(
    (e) {
      final json = e as Map<String, dynamic>;
      return News(
        id: json['id'] as String,
        title: json['header'] as String,
        publicationTime: DateTime.parse(['publication_time'] as String),
        thumbnail: (json['image_link'] as List<String>)[0],
        link: json['link'] as String,
      );
    },
  ).toList();
}
