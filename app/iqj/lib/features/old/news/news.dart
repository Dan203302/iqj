// import 'package:flutter/material.dart';
// import 'package:iqj/features/old/news/newsListGenerator.dart';
// import 'package:shimmer/shimmer.dart';

// class News extends StatefulWidget {
//   const News({super.key});

//   @override
//   State<News> createState() => _NewsState();
// }

// class _NewsState extends State<News> {
//   late Future<List<NewsArticle>> newsList;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   newsList = getNews();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         toolbarHeight: 72,
//         scrolledUnderElevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Новости',
//           style: TextStyle(
//             fontFamily: 'Inter',
//             fontSize: 32,
//             fontWeight: FontWeight.w900,
//           ),
//         ),
//         centerTitle: false,
//         actions: [
//           Container(
//             padding: const EdgeInsets.only(right: 12),
//             child: Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     //TODO
//                   },
//                   icon: const Icon(Icons.bookmarks_outlined),
//                 ),
//                 const SizedBox(
//                   width: 6,
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     showFilterDialog(context);
//                   },
//                   icon: const Icon(Icons.filter_alt_outlined),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<NewsArticle>>(
//         future: newsList,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center (child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: Text(snapshot.error.toString()),
//               // child: Text("Ошибка загрузки.")
//             );
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(
//               child: Text('Нет новостей!'),
//             );
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               final news = snapshot.data![index];
//               return NewsCard(
//                 title: news.title,
//                 description: news.description,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class NewsCard extends StatelessWidget {
//   final String title;
//   final String description;

//   const NewsCard({
//     super.key,
//     required this.title,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.all(8),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(description),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void showFilterDialog(BuildContext context) {
//   final Widget okButton = TextButton(
//     style: const ButtonStyle(
//       overlayColor: MaterialStatePropertyAll(Color.fromARGB(64, 239, 172, 0)),
//     ),
//     child: const Text(
//       "Закрыть",
//       style: TextStyle(
//         color: Color.fromARGB(255, 239, 172, 0),
//       ),
//     ),
//     onPressed: () {
//       Navigator.of(context).pop();
//     },
//   );

//   final AlertDialog alert = AlertDialog(
//     title: const Text(
//       "Фильтры",
//       style: TextStyle(
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//     content: const Text("Todo"),
//     actions: [
//       okButton,
//     ],
//   );

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

// Widget waitingForNewsAnim() {
//   return Shimmer.fromColors(
//     baseColor: Colors.black12,
//     highlightColor: Colors.white,
//     child: SizedBox(
//       height: 323,
//       width: 200,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     ),
//   );
// }
