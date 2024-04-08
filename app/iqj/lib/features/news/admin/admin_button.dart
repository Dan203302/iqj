import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iqj/features/news/presentation/screens/search/body_for_data/body.dart';

void admin_button(BuildContext context) { 
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add News'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                //controller: _titleController,
                decoration: InputDecoration(hintText: 'Title'),
              ),
              TextField(
                //controller: _contentController,
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
}