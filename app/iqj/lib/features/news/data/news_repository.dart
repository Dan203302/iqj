import 'package:iqj/features/news/domain/news.dart';

class NewsRepository {
  Future<List<News>> fetchNews() async {
    return Future.delayed(const Duration(seconds: 1), () {
      return [
        News(title: "Новость 1", description: "Описание новости 1"),
        News(title: "Новость 2", description: "Описание новости 2"),
        News(title: "Новость 3", description: "Описание новости 3"),
      ];
    });
  }
}
