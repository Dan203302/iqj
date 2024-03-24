// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iqj/features/news/data/news_repository.dart';
//import 'package:iqj/features/news/domain/news.dart';
import 'package:iqj/features/news/presentation/bloc/news_bloc.dart';
import 'package:iqj/features/news/presentation/screens/announcement.dart';
import 'package:iqj/features/news/presentation/screens/news_loaded_list.dart';
import 'package:iqj/features/old/news/newsListGenerator.dart';
import 'package:iqj/features/old/schedule.dart';
import 'package:iqj/main.dart';
import 'package:iqj/theme/text_theme.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:iqj/features/news/domain/news.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});
  
  @override
  State<NewsScreen> createState() => _NewsBloc();
}

class _NewsBloc extends State<NewsScreen>{
  //final _newsbloc=NewsBloc(newsRepository)
    //List<News>? _news_list;
    // final newsList = getNews();
    // final _newsbloc=NewsBloc(NewsArticle());
    //final newsList=NewsSmall();
    final _newsbloc=NewsBloc();
    
    static get title => null;
    
    @override
    void initState(){
      _newsbloc.add(LoadNewsList(completer: null));
      super.initState();
    }
    bool _isFilter = false;
    void searchfilter(){
      setState(() {
        _isFilter = !_isFilter;
      });
    }

  @override
  Widget build(BuildContext context) {
    // final newsBloc = BlocProvider.of<NewsBloc>(context);
    // newsBloc.add(FetchNews());
    //final _newslistbloc=NewsBloc(context);


    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('News'),
      // ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 72,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: _isFilter ? Container(
          width: 285,
          height: 23,
          margin: const EdgeInsets.only(left: 20.0, top: 20.0),
          child: const TextField(
            decoration: InputDecoration(
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(20.0),
              // ),
              //icon: Icon(Icons.search),
              hintText: "Поиск по заголовку ...",
              hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                height: 1.5,
              ),
              icon: Icon(Icons.search),
            ),
          ),
        ) :  Text(
          'Новости',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
        actions: _isFilter? [
          Container(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    searchfilter();
                  },
                  icon: SvgPicture.asset('assets/icons/news/filter2.svg'),
                ),
              ],
            ),
          ),
        ] : [
          Container(
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
                    searchfilter();
                  },
                  icon: SvgPicture.asset('assets/icons/news/filter2.svg'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          buildAnnouncement(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                final completer=Completer();
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
                        return NewsCard(news: news,);
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
