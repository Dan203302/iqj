// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iqj/features/news/admin/admin_button.dart';
import 'package:iqj/features/news/presentation/bloc/news_bloc.dart';
import 'package:iqj/features/news/presentation/screens/news_loaded_list.dart';
import 'package:iqj/features/news/presentation/screens/search/search_date.dart';
import 'package:iqj/features/news/presentation/screens/search/search_tags.dart';
import 'package:iqj/features/news/data/bookmarks.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsBloc();
}

class _NewsBloc extends State<NewsScreen> {
  //final _newsbloc=NewsBloc(newsRepository)
  //List<News>? _news_list;
  // final newsList = getNews();
  // final _newsbloc=NewsBloc(NewsArticle());
  //final newsList=NewsSmall();
  final _newsbloc = NewsBloc();

  static get title => null;

  @override
  void initState() {
    _newsbloc.add(LoadNewsList(completer: null));
    super.initState();
  }

  bool _isFilter = false;
  void searchfilter() {
    setState(() {
      _isFilter = !_isFilter;
    });
  }

  bool flag_close = true;
  void announce_close() {
    setState(() {
      flag_close = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final newsBloc = BlocProvider.of<NewsBloc>(context);
    // newsBloc.add(FetchNews());
    //final _newslistbloc=NewsBloc(context);
    final newsBloc = NewsBloc();
    GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('News'),
      // ),
      floatingActionButton: Container(
        width: 50.0, // Задаем ширину
        height: 50.0, // Задаем высоту
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary, // Цвет кнопки
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: IconButton(
          onPressed: () {
            admin_button(context);
          },
          icon: const Icon(Icons.edit),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        toolbarHeight: 72,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: _isFilter
            ? Container(
                width: 500,
                height: 45,
                margin: EdgeInsets.zero,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Поиск по заголовку...",
                      hintFadeDuration: const Duration(milliseconds: 100),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        height: 5,
                        color: Color.fromRGBO(128, 128, 128, 0.6),
                      ),
                      suffixIcon: SizedBox(
                        child: IconButton(
                          icon: const Icon(
                            Icons.search,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Text(
                'Новости',
                style: Theme.of(context).textTheme.titleLarge,
              ),
        centerTitle: false,
        actions: _isFilter
            ? [
                Container(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          //announce_close();
                          searchfilter();
                        },
                        //icon: SvgPicture.asset('assets/icons/news/filter2.svg'),
                        icon: const Icon(Icons.tune_rounded),
                      ),
                    ],
                  ),
                ),
              ]
            : [
                Container(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmarks_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          searchfilter();
                        },
                        icon: //SvgPicture.asset('assets/icons/news/filter2.svg'),
                            const Icon(Icons.tune_rounded),
                      ),
                    ],
                  ),
                ),
              ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isFilter)
            Container(
              margin: const EdgeInsets.only(
                  top: 12, left: 12, right: 12, bottom: 12),
              padding: const EdgeInsets.only(left: 12, right: 12),
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(50),
                            borderRadius: BorderRadius.circular(24.0),
                            color: const Color.fromRGBO(239, 172, 0, 1),
                          ),
                          child: TextButton(
                            onPressed: () {
                              searchdata(context);
                            },
                            child: const Text(
                              "По дате:                                  ",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(50),
                            borderRadius: BorderRadius.circular(24.0),
                            color: const Color.fromRGBO(239, 172, 0, 1),
                          ),
                          child: TextButton(
                            onPressed: () {
                              search_tags(context);
                            },
                            child: const Text(
                              "По тегам:                                ",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (flag_close)
            Container(
              margin: const EdgeInsets.only(left: 14, right: 12),
              child: Text(
                'Важные',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                  height: 1.5,
                ),
              ),
            ),
          if (flag_close)
            Container(
              margin: const EdgeInsets.only(
                  top: 12, left: 12, right: 12, bottom: 12),
              padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primaryContainer,
                // В дизайне же нет рамки вроде не было рамки 🤨
                // border: Border.all(
                //   color: const Color.fromARGB(255, 255, 166, 0),
                // ),
                // boxShadow: const [
                //   BoxShadow(
                //     blurRadius: 2,
                //     color: Color.fromARGB(255, 239, 172, 0),
                //     spreadRadius: 1,
                //   ),
                // ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: SvgPicture.asset(
                            'assets/icons/schedule/warning.svg',
                            semanticsLabel: 'warning',
                            height: 24,
                            width: 24,
                            allowDrawingOutsideViewBox: true,
                            // color: const Color.fromARGB(255, 239, 172, 0),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'С 35 нояктября по 64 апремая в корпусе В-78 будет закрыт главный вход. ',
                            softWrap: true,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 255, 166, 0),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              announce_close();
                            });
                          },
                          icon: SvgPicture.asset('assets/icons/news/close.svg'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (flag_close)
            Container(
              margin: const EdgeInsets.only(left: 12, right: 12),
              child: Divider(
                thickness: 1,
                color: Theme.of(context).colorScheme.surfaceVariant,
              ),
            ),
          Container(
            margin: const EdgeInsets.only(left: 14, right: 12, top: 10),
            child: Text(
              'Общее',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
                height: 1.5,
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                final completer = Completer();
                _newsbloc.add(LoadNewsList(completer: completer));
                return completer.future;
              },
              child: BlocBuilder<NewsBloc, NewsState>(
                bloc: _newsbloc,
                builder: (context, state) {
                  if (state is NewsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NewsLoaded) {
                    // return ListView.builder(
                    //   itemCount: state.newsList.length,
                    //   itemBuilder: (context, index) {
                    //     final news = state.newsList[index];
                    //     return ListTile(
                    //       title: Text(news.title),
                    //       subtitle: Text(news.description),
                    //     );
                    //   },
                    // );
                    return ListView.builder(
                      itemCount: state.newsList.length,
                      //itemCount: state.data!.length,
                      itemBuilder: (context, index) {
                        final news = state.newsList[index];
                        //print(news.thumbnail);
                        return NewsCard(
                          news: news,
                        );
                      },
                    );
                  } else if (state is NewsListLoadingFail) {
                    return Center(
                      child: Text(state.except?.toString() ?? "Error"),
                    );
                  } // else {
                  //   return Container();
                  // }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
