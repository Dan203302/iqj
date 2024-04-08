import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqj/features/news/presentation/bloc/news_bloc.dart';
import 'package:iqj/features/news/presentation/screens/search/body_for_data/body.dart';
import 'package:iqj/features/old/news/newsListGenerator.dart';

void admin_button(BuildContext context,NewsBloc newsBloc) { 
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  // final _newsBloc = newsBloc.BlocProvider(
  //   create: (context) => NewsBloc(),
  //   child: Container(),
  // );
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add News'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Title'),
              ),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(hintText: 'Content'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                // NewsModel news = NewsModel(
                //   title: _titleController.text,
                //   content: _contentController.text,
                // );
                // newsBloc.add(AddNews(news));
                final NewsSmall news = NewsSmall(
                  thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg", 
                title: _titleController.text, 
                date: "13.12.2005 :)", 
                description: _contentController.text,
                );
                //newsbloc.add(AddNewsEvent(news: news));
                newsBloc.add(AddNewsEvent(news: news));
                Navigator.of(context).pop();
                Future.delayed(Duration.zero, () {
                  _refreshIndicatorKey.currentState?.show();
                });
              },
            ),
          ],
        );
      },
    );
}