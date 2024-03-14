import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqj/features/news/presentation/bloc/news_bloc.dart';
// import 'package:iqj/features/news/domain/news.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsBloc = BlocProvider.of<NewsBloc>(context);
    newsBloc.add(FetchNews());

    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
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
          } else if (state is NewsError) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
