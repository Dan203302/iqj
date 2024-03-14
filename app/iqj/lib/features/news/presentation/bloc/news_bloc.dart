import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqj/features/news/data/news_repository.dart';
import 'package:iqj/features/news/domain/news.dart';

// Events
abstract class NewsEvent {}

class FetchNews extends NewsEvent {}

// States
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<News> newsList;

  NewsLoaded(this.newsList);
}

class NewsError extends NewsState {
  final String errorMessage;

  NewsError(this.errorMessage);
}

// Bloc
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc(this.newsRepository) : super(NewsInitial());

  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchNews) {
      yield NewsLoading();
      try {
        final List<News> newsList = await newsRepository.fetchNews();
        yield NewsLoaded(newsList);
      } catch (e) {
        yield NewsError("Failed to fetch news: $e");
      }
    }
  }
}
