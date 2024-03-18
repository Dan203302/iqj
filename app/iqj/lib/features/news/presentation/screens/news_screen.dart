// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqj/features/news/data/news_repository.dart';
//import 'package:iqj/features/news/domain/news.dart';
import 'package:iqj/features/news/presentation/bloc/news_bloc.dart';
// import 'package:iqj/features/news/domain/news.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});
  
  @override
  State<NewsScreen> createState() => _NewsBloc();
}

class _NewsBloc extends State<NewsScreen>{
  //final _newsbloc=NewsBloc(newsRepository)
    //List<News>? _news_list;
    final _newsbloc=NewsBloc(NewsRepository());
    
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
              return ListView.builder(
                itemCount: state.newsList.length,
                itemBuilder: (context, index) {
                  final news = state.newsList[index];
                  return ListTile(
                    title: Text(news.title),
                    subtitle: Text(news.description),
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
