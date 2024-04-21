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
          arguments: {'id':news.id},
        );
      },
      child: Card(
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      news.thumbnails,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 6)),
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            news.title,
                            //news.id,
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
                    const Padding(padding: EdgeInsets.only(bottom: 6)),
                    Text(
                      "${DateFormat('dd.MM.yyyy hh:mm').format(news.publicationTime)}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
