
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:iqj/features/news/domain/news.dart';

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({super.key, required this.news});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          'newslist',
          arguments: news,
        );
    },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(news.thumbnail),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      news.title,
                      style: const TextStyle(
                        fontSize: 30,
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
                    icon: SvgPicture.asset('assets/icons/news/bookmark.svg'),
                  ),
                ],
              ),
              Text(DateFormat.yMMMd('ru_RU').format(news.publicationTime)),
            ],
          ),
        ),
      ),
    );
  }
}