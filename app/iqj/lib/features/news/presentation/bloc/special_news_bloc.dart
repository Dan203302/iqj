import 'dart:async';
import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqj/features/news/data/news_repository.dart';
import 'package:iqj/features/news/domain/special_news.dart';

abstract class SpecialNewsLoadEvent {}

class FetchSpecialNews extends SpecialNewsLoadEvent {}

class LoadSpecialNewsLoadList extends SpecialNewsLoadEvent{
  final Completer? completer;
  LoadSpecialNewsLoadList({required this.completer});

  List<Object?> get props => [completer];
  
}


// States
abstract class SpecialNewsLoadState {}

class SpecialNewsLoadInitial extends SpecialNewsLoadState {}

class SpecialNewsLoadLoading extends SpecialNewsLoadState {}

class SpecialNewsLoadLoaded extends SpecialNewsLoadState {
  final List<SpecialNews> newsList;

  SpecialNewsLoadLoaded(this.newsList);
}

class NewsLoadError extends SpecialNewsLoadState {
  final String errorMessage;

  NewsLoadError(this.errorMessage);
}

class NewsLoadListLoadingFail extends SpecialNewsLoadState{
  final Object? except;

  NewsLoadListLoadingFail({required this.except});
  List<Object?> get pros => [except];
}

class NewsLoadBloc extends Bloc<SpecialNewsLoadEvent,SpecialNewsLoadState>{
  final String id;

  NewsLoadBloc(this.id): super(SpecialNewsLoadInitial()){
    on<LoadSpecialNewsLoadList>((event,emit) async{
      try {
        if (state is! SpecialNewsLoadLoaded) {
          emit(SpecialNewsLoadLoading());
        }
        final List<SpecialNews> news = await getSpecialNews();
        //print(newsList);
        emit(SpecialNewsLoadLoaded(news));
      } catch (e) {
        emit(NewsLoadListLoadingFail(except: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
