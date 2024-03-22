
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iqj/features/news/presentation/screens/news_loaded_list_screen.dart';
import 'package:iqj/features/news/presentation/screens/news_screen.dart';

class NewsCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String date;
  final String description;
  const NewsCard(
      {super.key, 
      required this.thumbnail,
      required this.title,
      required this.date,
      required this.description,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewsList()), 
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
              Image.network(thumbnail),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
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
              Text(date),
              const SizedBox(height: 8),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}