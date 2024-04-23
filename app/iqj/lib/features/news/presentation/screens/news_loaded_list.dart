import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:iqj/features/news/domain/news.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iqj/features/news/data/bookmarks.dart';

class NewsCard extends StatefulWidget {
  final News news;
  bool bookmarked;
  final Function onBookmarkToggle;

  NewsCard({super.key, required this.news, required this.bookmarked, required this.onBookmarkToggle});

  @override
  State<StatefulWidget> createState() => _NewsCard();
}

class _NewsCard extends State<NewsCard> {
  bool bookmarked = false;

  Widget _buildThumbnailImage() {
    try {
      return Container(
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            widget.news.thumbnails,
            fit: BoxFit.fitWidth,
            height: 256,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return Container();
            }
          ),
        ),
      );
    } catch (e) {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          'newslist',
          arguments: {'id': widget.news.id},
        );
      },
      child: Card(
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: _buildThumbnailImage(),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 6)),
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.news.title,
                            //news.id,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              // title,
                              // style: textTheme.titleLarge
                            ),
                          ),
                        ),
                        IconButton(
                          icon: widget.bookmarked
                              ? (Icon(
                                  Icons.bookmark_rounded,
                                  size: 28,
                                  color: Theme.of(context).colorScheme.primary,
                                ))
                              : (Icon(
                                  Icons.bookmark_border,
                                  size: 28,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                )),
                          onPressed: () {
                            setState(() {
                              widget.bookmarked = !widget.bookmarked;
                              BookmarkProvider.toggleBookmark(widget.news.id);
                            });
                            // SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
                            // Map<String, dynamic> user = {'Username':'tom','Password':'pass@123'};
                            // bool result = await prefs.setString('user', jsonEncode(user));
                          },
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 6)),
                    Text(
                      "${DateFormat('dd.MM.yyyy hh:mm').format(widget.news.publicationTime)}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
