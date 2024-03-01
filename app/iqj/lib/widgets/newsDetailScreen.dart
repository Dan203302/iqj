import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newsImage;
  final String newsTitle;
  final String newsDate;
  final String description;
  final String content;
  final String source ;
  const NewsDetailScreen({super.key, required this.newsImage, required this.newsTitle, required this.newsDate, required this.description, required this.content, required this.source, 

   });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  //final format = DateFormat()
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1 ;
    final height = MediaQuery.sizeOf(context).height * 1 ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
           //TODO;
          },
          icon: SvgPicture.asset('assets/icons/news/arrow.svg'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //TODO
            },
            icon: SvgPicture.asset('assets/icons/news/bookmarks.svg'),
          ),
          const SizedBox(width: 6,),
        
          IconButton(
            onPressed: () {
              //TODO
            },
            icon: SvgPicture.asset('assets/icons/news/filter.svg'),
          ),
          
        
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: Container(
              height: height * .45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
              ),
              //TODO картинка
              // child: CachedNetworkImage(
              //     imageUrl: widget.newsImage
              //   fit: BoxFit.cover,
              //   placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              // ),
            ),
          ),
          Container(
            height: height * 6,
            margin: EdgeInsets.only(top: height * .4),
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration:  const BoxDecoration(
              color: Colors.white,
            ),
            child:  ListView(
              children: [
                  Text(
                  widget.newsTitle, 
                  style:  const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20, 
                    color: Color(0xFF152536),
                    fontWeight: FontWeight.w900,
                  ),
                
                ),
                SizedBox(height: height * .02,),
                 Row(
                  children: [
                    Text(
                      //'ресурс новости',
                      widget.source, 
                    style:  const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13, 
                    color: Color(0xFF152536),
                    fontWeight: FontWeight.w600,
                  ),),
                  ],
                ),
                  //TODO дата
                SizedBox(height: height * .03,),
                 Text(
                    //'Описание новости',
                    widget.description, 
                    style:  const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13, 
                    color: Color(0xFF152536),
                    fontWeight: FontWeight.w600,
                  ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
