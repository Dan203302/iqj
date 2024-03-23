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
      body: Container(
        child: Text(news?.title ?? '...')
        ),
    );
  }

}