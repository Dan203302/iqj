import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iqj/features/news/domain/news.dart';

Future<List<News>> getNews() async {
  final response = await http.get(
    //https://92.63.105.190/news?offset=0&count=200
    Uri(
      scheme: 'https', 
      host: 'mireaiqj.ru',
      port: 8443,
      path: '/news',
      queryParameters: {'offset': '0', 'count': '15'},
      //TODO сделать offset динамически изменяемым, чтоб получать следующие новости при страницы
    ),
  );
  if (response.statusCode == 200) {
    // final List body = (json.decode(response.body)
    //     as Map<String, dynamic>)['products'] as List;
    // return body.map(
    //   (e) {
    //     final json = e as Map<String, dynamic>;
    //     return News(
    //       id: json['id'] as String,
    //       title: json['header'] as String,
    //       publicationTime: DateTime.parse(['publication_time'] as String),
    //       thumbnail: (json['image_link'] as List<String>)[0],
    //       link: json['link'] as String,
    //     );
    //   },
    // ).toList();
    final dynamic decodedData = json.decode(response.body);
    List<News> newsList = [];
        final List<dynamic> jsonList = decodedData as List;
        // final dynamic hi = jsonList[0];
        // print(hi['image_link'][0]);
        newsList = jsonList.map((json) {
            return News(
                id: json['id'] as String,
                title: json['header'] as String,
                publicationTime: DateTime.parse(json['publication_time'] as String),
                thumbnail: json['image_link'][0] as String,
                link: json['link'] as String,
            );
        }).toList();
        return newsList;
  } else {
    throw Exception(response.statusCode);
  }
}