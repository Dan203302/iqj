class News {
  final String id;
  final String title;
  final String thumbnail;
  final DateTime publication_time;
  final String link;
  News(
      {required this.id,
      required this.title,
      required this.thumbnail,
      required this.publication_time,
      required this.link});
}
