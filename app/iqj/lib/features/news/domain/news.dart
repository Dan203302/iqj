class News {
  final String id;
  final String title;
  // final List<String> thumbnails;
  final String thumbnails;
  //final List<String> tags; ////////////// РАСКОММЕНТИРОВАТЬ КОГДА АПИ БУДЕТ ГОТОВО
  final DateTime publicationTime;
  final String description; ////////////// РАСКОММЕНТИРОВАТЬ КОГДА АПИ БУДЕТ ГОТОВО
  final String link;
  News({
    required this.id,
    required this.title,
    required this.thumbnails,
    //required this.tags, ////////////// РАСКОММЕНТИРОВАТЬ КОГДА АПИ БУДЕТ ГОТОВО
    required this.publicationTime,
    required this.description, ///////////// РАСКОММЕНТИРОВАТЬ КОГДА АПИ БУДЕТ ГОТОВО
    required this.link,
  });
}
