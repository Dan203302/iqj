

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iqj/features/news/presentation/screens/news_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _Chats_Screen();
}


class  _Chats_Screen extends State<ChatsScreen> {

  bool _isFilter = false;
  void searchfilter() {
    setState(() {
      _isFilter = !_isFilter;
    });
  }

  
// TabController _tabController;

// @override
// void initState() {
//   super.initState();
//   _tabController = TabController(length:2,vsync: _tabController);
// }

// @override
// void dispose() {
//   _tabController.dispose();
//   super.dispose();
// }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar( 
        title: _isFilter
            ? Container(
                width: 500,
                height: 45,
                margin: EdgeInsets.zero,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Поиск по заголовку...",
                      hintFadeDuration: const Duration(milliseconds: 100),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        height: 5,
                        color: Color.fromRGBO(128, 128, 128, 0.6),
                      ),
                      suffixIcon: SizedBox(
                        child: IconButton(
                          icon: const Icon(
                            Icons.search,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Text(
                'Чаты',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            actions: _isFilter
            ? [
                Container(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          //announce_close();
                          searchfilter();
                        },
                        //icon: SvgPicture.asset('assets/icons/news/filter2.svg'),
                        icon: Icon(
                          Icons.tune_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.primary.withAlpha(64),
                        )),
                      ),
                    ],
                  ),
                ),
              ]
            : [
                Container(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          searchfilter();
                        },
                        icon: //SvgPicture.asset('assets/icons/news/filter2.svg'),
                            _isFilter
                                ? Icon(
                                    Icons.tune_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                : const Icon(Icons.tune_rounded),
                      ),
                      IconButton(
                        onPressed: () => {},
                         icon: Icon(Icons.more_vert)
                        )
                    ],
                  ),
                ),
              ],
              // bottom: TabBar(
              //   controller: _tabController,
              //   indicatorPadding: EdgeInsets.only(top: 10,bottom: 10),
              //   tabs: [
              //     Tab( 
                    
              //       child: Container( 
              //         decoration: BoxDecoration( 
              //           borderRadius: BorderRadius.circular(50),
              //           border: Border.all(),
              //         ),
              //         child: Align( 
              //           alignment: Alignment.center,
              //           child: Text('Mes'),
              //         ),
              //       ),
              //     ),
              //     Tab( 
              //       child: Container( 
              //         decoration: BoxDecoration( 
              //           borderRadius: BorderRadius.circular(50),
              //           border: Border.all(),
              //         ),
              //         child: Align( 
              //           alignment: Alignment.center,
              //           child: Text('Mes'),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
      ),
    );
  }

}