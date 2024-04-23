// import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
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

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:iqj/features/news/data/news_repository.dart';
import 'package:iqj/features/news/domain/news.dart';
import 'package:intl/intl.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

abstract class NewsLoadEvent {}

class FetchNews extends NewsLoadEvent {}

class LoadNewsLoadList extends NewsLoadEvent {
  //final String id;
  final Completer? completer;
  LoadNewsLoadList({required this.completer});
  List<Object?> get props => [completer];
}

// States
abstract class NewsLoadState {}

class NewsLoadInitial extends NewsLoadState {}

class NewsLoadLoading extends NewsLoadState {}

class NewsLoadLoaded extends NewsLoadState {
  final News news;
  bool flagOpenTags = false;
  NewsLoadLoaded(this.news, this.flagOpenTags);

  //News get news => null;
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
    //print("init bloc");
    on<LoadNewsLoadList>((event, emit) async {
      try {
        if (state is! NewsLoadLoaded) {
          //print("news load loading now");
          emit(NewsLoadLoading());
        }
        //print("Start load news");
        final News news = await getNewsFull(id);
        //print("News loaded");
        emit(NewsLoadLoaded(news, false));
      } catch (e) {
        print("error: " + NewsLoadListLoadingFail(except: e).toString());
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
      final News news = News(
        id: decodedData['id'] as String,
        title: decodedData['header'] as String,
        publicationTime:
            DateTime.parse(decodedData['publication_time'] as String),
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

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String newsId = args['id']!;

    return BlocProvider(
      create: (context) => NewsLoadBloc(newsId),
      child: _NewsListWidget(),
    );
  }
}

class _NewsListWidget extends StatefulWidget {
  bool bookmarked = false;
  @override
  __NewsListWidgetState createState() => __NewsListWidgetState();
}

class __NewsListWidgetState extends State<_NewsListWidget> {
  bool flagOpenTags = true;
  bool bookmarked = false;
  Map dataf = {};
  // late final NewsLoadBloc _newsLoadBloc;

  // void _initializeBloc() async {
  //   _newsLoadBloc = NewsLoadBloc('15');
  //   //await _newsLoadBloc.initialize(); // Предполагается, что у вашего блока есть метод инициализации
  // }

  @override
  Widget build(BuildContext context) {
    final NewsLoadBloc bloc = context.read<NewsLoadBloc>();
    final loadCompleter = Completer();
    bloc.add(
      LoadNewsLoadList(
        completer: loadCompleter,
      ),
    );

    final NewsTags ntags = NewsTags();

    void openCloseTags() {
      setState(() {
        flagOpenTags = !flagOpenTags;
      });
    }

    void bookmarkFlagger() {
      setState(() {
        bookmarked = !bookmarked;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Новость'),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    bookmarkFlagger();
                  },
                  icon: widget.bookmarked
                      ? (Icon(
                          Icons.bookmark_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ))
                      : (Icon(
                          Icons.bookmark_outline_rounded,
                        )),
                ),
                PopupMenuButton<String>(
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Поделиться...', 'Подробнее...'}
                        .map((String choice) {
                      return 
                      choice == "Поделиться..." ? 
                      PopupMenuItem<String>(
                        value: choice,
                        child: Row(children: [
                          Icon(Icons.share_outlined),
                          Padding(padding: EdgeInsets.only(right: 12),),
                          Text(choice),
                          ],
                          ),
                      ) :
                      PopupMenuItem<String>(
                        value: choice,
                        child: Row(children: [
                          Icon(Icons.info_outline_rounded),
                          Padding(padding: EdgeInsets.only(right: 12),),
                          Text(choice),
                          ],
                          ),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<NewsLoadBloc>(
            create: (_) => bloc,
          ),
        ],
        child: BlocBuilder<NewsLoadBloc, NewsLoadState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is NewsLoadLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NewsLoadLoaded) {
              final News news = state.news;
              return ListView(
                children: [
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 12, right: 12, top: 12),
                              width: double.infinity,
                              height: 256,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  news.thumbnails,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 6)),
                          Container(
                            margin: const EdgeInsets.only(left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        news.title,
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          // title,
                                          // style: textTheme.titleLarge
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat('dd.MM.yyyy hh:mm')
                                          .format(news.publicationTime),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        // Text(
                                        //   "ID: $newsId",
                                        //   style: TextStyle(
                                        //     color: Theme.of(context)
                                        //         .colorScheme
                                        //         .onSurfaceVariant,
                                        //     fontSize: 16,
                                        //   ),
                                        // ),
                                        if (flagOpenTags)
                                          IconButton(
                                            onPressed: () {
                                              openCloseTags();
                                            },
                                            icon: //SvgPicture.asset('assets/icons/news/open_tags.svg'),
                                                const Icon(
                                                    Icons.expand_more_rounded),
                                          )
                                        else
                                          IconButton(
                                            onPressed: () {
                                              openCloseTags();
                                            },
                                            icon: //SvgPicture.asset('assets/icons/news/open_tags_yel.svg'),
                                                Icon(
                                              Icons.expand_less_rounded,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                if (!flagOpenTags) ntags,
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        width: 2,
                                      ),
                                      //bottom: BorderSide(color: Color.fromRGBO(202, 196, 208, 1), width: 2),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                //Text(news?.description ?? '...'),  ////////////// РАСКОММЕНТИРОВАТЬ КОГДА АПИ БУДЕТ ГОТОВО
                                Linkify(
                                  // onOpen: (link) async { FIX ME
                                  //   if (!await launchUrl(Uri.parse(link.url))) {
                                  //     throw Exception('Could not launch ${link.url}');
                                  //   }
                                  // },
                                  text: cleanText(news.description),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontSize: 16,
                                  ),
                                  linkStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 16,
                                    decorationColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
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

class NewsTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> tags = ["Tag 1", "Tag 2", "Tag 3"];
    return AnimatedSize(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 250),
      child: Container(
          margin: EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              tags.length,
              (index) => Container(
                margin: const EdgeInsets.only(right: 5),
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: TextButton(
                  onPressed: () {
                    // Переходим к ленте новостей с фильтром по нажатому тегу
                  },
                  child: Text(
                    tags[index], // берем название тега из массива
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

String cleanText(String text) {
  text = text.replaceAll(RegExp(r'\n{3,}'), '\n\n');
  text = text.replaceAll('\t', '');
  return text;
}

void handleClick(String value) {
  switch (value) {
    case 'Поделиться...':
      break;
    case 'Подробнее...':
      break;
  }
}
