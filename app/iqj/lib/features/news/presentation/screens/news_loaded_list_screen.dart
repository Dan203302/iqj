import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:iqj/features/news/domain/news.dart';
import 'package:iqj/features/news/presentation/bloc/news_bloc.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<StatefulWidget> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  // thumbnail: thumbnail,
  //         title: title,
  //         date: date,
  //         description: description,
  // String? thumbnail;
  // String? title;
  // String? date;
  // String? decoration;
  late News news;

  bool flag_open_tags = false;
  void open_close_tags() {
    setState(() {
      flag_open_tags = !flag_open_tags;
    });
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is News, "Check args");
    news = args as News;
    //title = args as String;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 72,
          scrolledUnderElevation: 0,
          //title: const Text("Новости"),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: //SvgPicture.asset('assets/icons/news/bookmark2.svg'),
                        const Icon(Icons.bookmarks_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      //searchfilter();
                    },
                    icon: //SvgPicture.asset('assets/icons/news/filter3.svg'),
                        const Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
          ]),
      body: ListView(
        children: [
          Card(
            elevation: 2,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          news.thumbnail,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 6)),
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('yyyy.MM.dd')
                          .format(news.publicationTime)),
                      const Spacer(),
                      if (!flag_open_tags)
                        IconButton(
                          onPressed: () {
                            open_close_tags();
                          },
                          icon: SvgPicture.asset(
                              'assets/icons/news/open_tags.svg'),
                        )
                      else
                        IconButton(
                          onPressed: () {
                            open_close_tags();
                          },
                          icon: SvgPicture.asset(
                              'assets/icons/news/open_tags_yel.svg'),
                        )
                    ],
                  ),
                  if (flag_open_tags) const Text("Здесь будут теги"),
                  const SizedBox(height: 8),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                            color: Color.fromRGBO(209, 209, 209, 1), width: 2),
                        //bottom: BorderSide(color: Color.fromRGBO(202, 196, 208, 1), width: 2),
                      ),
                    ),
                  ),
                  // Text(news?.description ?? '...'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
