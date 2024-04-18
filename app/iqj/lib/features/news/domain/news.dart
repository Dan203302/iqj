class News {
  final String id;
  final String title;
  // final List<String> thumbnails;
  final String thumbnails;
  //final List<String> tags;
  final DateTime publicationTime;
  final String link;
  News({
    required this.id,
    required this.title,
    required this.thumbnails,
    //required this.tags,
    required this.publicationTime,
    required this.link,
  });
}
