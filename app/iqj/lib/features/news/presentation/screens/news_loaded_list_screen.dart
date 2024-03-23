import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iqj/features/news/presentation/bloc/news_bloc.dart';
import 'package:iqj/features/old/news/newsListGenerator.dart';


class NewsList extends StatefulWidget{
  const NewsList({super.key});

  @override
  State<StatefulWidget> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList>{
  // thumbnail: thumbnail, 
  //         title: title, 
  //         date: date, 
  //         description: description,
  // String? thumbnail;
  // String? title;
  // String? date;
  // String? decoration;
  NewsSmall? news;

  @override
  void didChangeDependencies(){
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args!=null && args is NewsSmall , "Check args");
    news = args as NewsSmall;
    //title = args as String;
    setState(() {
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        scrolledUnderElevation: 0,
        title: const Text("Новости"),
        actions: [Container(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                  },
                  icon: SvgPicture.asset('assets/icons/news/bookmark2.svg'),
                ),
                IconButton(
                  onPressed: () {
                    //searchfilter();
                  },
                  icon: SvgPicture.asset('assets/icons/news/filter2.svg'),
                ),
              ],
            ),
          ), ]
        ),
      body: Card(
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(news?.thumbnail ?? '...'),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      news?.title ?? '...',
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
                    icon: SvgPicture.asset('assets/icons/news/bookmarkFilled.svg'),
                  ),
                ],
              ),
              Text(news?.date ?? '...'),
              const SizedBox(height: 8),
              Text(news?.description ?? '...'),
            ],
          ),
        ),
      ),
    );
  }

}