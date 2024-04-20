// import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:iqj/features/news/domain/news.dart';
// import 'package:iqj/features/news/presentation/bloc/news_bloc.dart';
// import 'package:iqj/features/news/presentation/bloc/news_loaded_bloc.dart';

// class NewsList extends StatefulWidget {
//   const NewsList({Key? key}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() => _NewsListState();
// }
// class _NewsListState extends State<NewsList> {
//   late News news;
//   bool flagOpenTags = false;
//   void openCloseTags() {
//     setState(() {
//       flagOpenTags = !flagOpenTags;
//     });
//   }
//   @override
//   void didChangeDependencies() {
//     final args = ModalRoute.of(context as BuildContext)?.settings.arguments;
//     assert(args != null && args is News, "Check args");
//     news = args as News;
//     setState(() {});
//     super.didChangeDependencies();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 72,
//         scrolledUnderElevation: 0,
//         actions: [
//           Container(
//             padding: const EdgeInsets.only(right: 12),
//             child: Row(
//               children: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.bookmarks_outlined),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.more_vert),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: Expanded(
//         child: BlocBuilder<NewsLoadBloc, NewsLoadState>(
//           builder: (context, state) {
//             if (state is NewsLoadLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state is NewsLoadLoaded) {
//               return Container(child: Text('hi'),);
//             } else if (state is NewsLoadListLoadingFail) {
//               return Center(
//                 child: Text(state.except?.toString() ?? "Error"),
//               );
//             } 
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }


// Widget LoadNewsBody(BuildContext context,News news,bool flag_open_tags){
//   return ListView(
//         children: [
//           Card(
//             elevation: 2,
//             margin: const EdgeInsets.all(8),
//             child: Padding(
//               padding: EdgeInsets.zero,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Container(
//                       width: double.infinity,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(6),
//                         child: Image.network(
//                           news.thumbnails,
//                           fit: BoxFit.fitWidth,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Padding(padding: EdgeInsets.only(bottom: 6)),
//                   Container(
//                     margin: const EdgeInsets.only(left: 12, right: 12),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 news.title,
//                                 style: const TextStyle(
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.bold,
//                                   // title,
//                                   // style: textTheme.titleLarge
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               DateFormat('dd.MM.yyyy')
//                                   .format(news.publicationTime),
//                               style: TextStyle(
//                                 color: Theme.of(context)
//                                     .colorScheme
//                                     .onSurfaceVariant,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 // На всякий
//                                 Text(
//                                   "ID: ${news.id}",
//                                 style: TextStyle(
//                                 color: Theme.of(context)
//                                     .colorScheme
//                                     .onSurfaceVariant,
//                                 fontSize: 16,
//                                 ),
//                                 ),
//                             if (!flag_open_tags)
//                               IconButton(
//                                 onPressed: () {
//                                   //open_close_tags();
//                                 },
//                                 icon: //SvgPicture.asset('assets/icons/news/open_tags.svg'),
//                                     const Icon(Icons.expand_more_rounded),
//                               )
//                             else
//                               IconButton(
//                                 onPressed: () {
//                                   //open_close_tags();
//                                 },
//                                 icon: //SvgPicture.asset('assets/icons/news/open_tags_yel.svg'),
//                                     Icon(
//                                   Icons.expand_less_rounded,
//                                   color: Theme.of(context).colorScheme.primary,
//                                 ),
//                               ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         if (flag_open_tags) 
//                         Text("Здесь будут теги",
//                           style: TextStyle(
//                                 color: Theme.of(context)
//                                     .colorScheme
//                                     .onSurfaceVariant,
//                                 fontSize: 16,
//                                 ),
//                         ),
//                         if (flag_open_tags)
//                           const Padding(padding: EdgeInsets.only(bottom: 6)),
//                         Container(
//                           height: 1,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border(
//                               top: BorderSide(
//                                 color: Theme.of(context).colorScheme.surface,
//                                 width: 2,
//                               ),
//                               //bottom: BorderSide(color: Color.fromRGBO(202, 196, 208, 1), width: 2),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 8),
//                         //Text(news?.description ?? '...'),  ////////////// РАСКОММЕНТИРОВАТЬ КОГДА АПИ БУДЕТ ГОТОВО
//                         Text('Здесь будет текст',
//                           style: TextStyle(
//                             color: Theme.of(context)
//                                     .colorScheme
//                                     .onSurfaceVariant,
//                             fontSize: 16,
//                             ),
//                         ),
//                         const SizedBox(height: 8),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       );
// }


import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:iqj/features/news/data/news_repository.dart';
import 'package:iqj/features/news/domain/news.dart';
abstract class NewsLoadEvent {}
class FetchNews extends NewsLoadEvent {}
class LoadNewsLoadList extends NewsLoadEvent {
  final Completer? completer;
  LoadNewsLoadList({required this.completer});
  List<Object?> get props => [completer];
}
// States
abstract class NewsLoadState {}
class NewsLoadInitial extends NewsLoadState {}
class NewsLoadLoading extends NewsLoadState {}
class NewsLoadLoaded extends NewsLoadState {
  final News newsList;
  NewsLoadLoaded(this.newsList);
}
class NewsLoadError extends NewsLoadState {
  final String errorMessage;
  NewsLoadError(this.errorMessage);
}
class NewsLoadListLoadingFail extends NewsLoadState {
  final Object? except;
  NewsLoadListLoadingFail({required this.except});
  List<Object?> get pros => [except];
}
class NewsLoadBloc extends Bloc<NewsLoadEvent, NewsLoadState> {
  final String id;
  NewsLoadBloc(this.id) : super(NewsLoadInitial()) {
    on<LoadNewsLoadList>((event, emit) async {
      try {
        if (state is! NewsLoadLoaded) {
          emit(NewsLoadLoading());
        }
        final News news = await getNewsFull(id);
        emit(NewsLoadLoaded(news));
      } catch (e) {
        emit(NewsLoadListLoadingFail(except: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
Future<News> getNewsFull(String id) async {
  final response = await http.get(
    Uri(
      scheme: 'https',
      host: 'mireaiqj.ru',
      port: 8443,
      path: '/news_id',
      queryParameters: {'id': id},
    ),
  );
  if (response.statusCode == 200) {
    final dynamic decodedData = json.decode(response.body);
    List<News> newsList = [];
    if (decodedData is List) {
      newsList = List<News>.from(decodedData.map((json) => News(
            description: json['text'] as String,
            id: json['id'] as String,
            title: json['header'] as String,
            publicationTime: DateTime.parse(json['publication_time'] as String),
            thumbnails: (json['image_link'] as List<String>).isNotEmpty
                ? json['image_link'][0] as String
                : '',
            link: json['link'] as String,
          )));
    } else if (decodedData is Map<String, dynamic>) {
      News news = News(
        id: decodedData['id'] as String,
        title: decodedData['header'] as String,
        publicationTime: DateTime.parse(decodedData['publication_time'] as String),
        thumbnails: decodedData['image_link'][0] as String,
        link: "decodedData['link'] as String",
        description: decodedData['text'] as String,
      );
      newsList.add(news);
    }
    return newsList[0];
  } else {
    throw Exception(response.statusCode);
  }
}
class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);
  
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  late News news;
  bool flagOpenTags = false;
  late final NewsLoadBloc _newsLoadBloc;

  void openCloseTags() {
    setState(() {
      flagOpenTags = !flagOpenTags;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeBloc();
  }

  void _initializeBloc() async {
    _newsLoadBloc = NewsLoadBloc('15');
    //await _newsLoadBloc.initialize(); // Предполагается, что у вашего блока есть метод инициализации
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News List'),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmarks_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<NewsLoadBloc>(
            create: (_)  => NewsLoadBloc('41'),
          ),
        ],
        child: BlocBuilder<NewsLoadBloc, NewsLoadState>(
          bloc: _newsLoadBloc,
          builder: (context, state) {
            if (state is NewsLoadLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NewsLoadLoaded) {
              return Container(child: Text('hi'));
            } else if (state is NewsLoadListLoadingFail) {
              return Center(
                child: Text(state.except?.toString() ?? "Error"),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
