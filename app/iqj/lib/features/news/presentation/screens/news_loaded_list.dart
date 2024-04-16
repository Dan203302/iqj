import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:iqj/features/news/domain/news.dart';

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          'newslist',
          arguments: news,
        );
      },
      child: Card(
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    width: double.infinity,
                    child: Image.network(
                      news.thumbnail,
                      fit: BoxFit.fill,
                    )),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 6)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      news.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        // title,
                        // style: textTheme.titleLarge
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Обработка нажатия кнопки
                    },
                    icon: const Icon(
                      Icons.bookmark_border,
                      size: 28,
                    ),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ],
              ),
              Text(DateFormat('yyyy.MM.dd').format(news.publicationTime)),
            ],
          ),
        ),
      ),
    );
  }
}
