// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqj/features/news/data/news_repository.dart';
//import 'package:iqj/features/news/domain/news.dart';
import 'package:iqj/features/news/presentation/bloc/news_bloc.dart';
import 'package:iqj/features/old/news/newsListGenerator.dart';
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

  @override
  Widget build(BuildContext context) {
    // final newsBloc = BlocProvider.of<NewsBloc>(context);
    // newsBloc.add(FetchNews());
    //final _newslistbloc=NewsBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: RefreshIndicator(
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
                  return NewsCard(
                    title: news.title,
                    description: news.description,
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
    );
  }
}


class NewsCard extends StatelessWidget {
  final String title;
  final String description;

  const NewsCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}
