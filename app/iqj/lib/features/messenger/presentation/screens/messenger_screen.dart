import 'package:flutter/material.dart';
import 'package:iqj/features/messenger/presentation/screens/chat_bubble.dart';
import 'package:iqj/features/messenger/presentation/screens/highlight_chat_bubble.dart';

class MessengerScreen extends StatefulWidget {
  const MessengerScreen({super.key});

  @override
  State<MessengerScreen> createState() => _MessengerBloc();
}

class _MessengerBloc extends State<MessengerScreen> {
  bool _isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: _isSearch
            ? SizedBox(
                width: 500,
                height: 45,
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
                        horizontal: 12,
                        vertical: 10,
                      ),
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
        centerTitle: false,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    _isSearch = !_isSearch;
                  },
                  icon: const Icon(Icons.search),
                ),
                PopupMenuButton<String>(
                  onSelected: (String choice) {},
                  itemBuilder: (BuildContext context) {
                    return {'Настройки', 'Статус'}.map((String choice) {
                      return choice == "Настройки"
                          ? PopupMenuItem<String>(
                              value: choice,
                              child: Row(
                                children: [
                                  const Icon(Icons.settings_outlined),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 12),
                                  ),
                                  Text(choice),
                                ],
                              ),
                            )
                          : PopupMenuItem<String>(
                              value: choice,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.tag_faces_sharp,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 12),
                                  ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.only(bottom: 12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(right: 12)),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                  child: const Text('Все'),
                ),
                const Padding(padding: EdgeInsets.only(right: 6)),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.onSurface,
                    ),
                    //backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
                  ),
                  child: const Text('Группы'),
                ),
                const Padding(padding: EdgeInsets.only(right: 6)),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.onSurface,
                    ),
                    //backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
                  ),
                  child: const Text('Студенты'),
                ),
                const Padding(padding: EdgeInsets.only(right: 6)),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.onSurface,
                    ),
                    //backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
                  ),
                  child: const Text('Преподаватели'),
                ),
                const Padding(padding: EdgeInsets.only(right: 6)),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.onSurface,
                    ),
                    //backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
                  ),
                  child: const Text('Руководство'),
                ),
                const Padding(padding: EdgeInsets.only(right: 6)),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.onSurface,
                    ),
                    //backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
                  ),
                  child: const Text('Прочее'),
                ),
                const Padding(padding: EdgeInsets.only(right: 12)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                // Чат текущей пары
                HighlightChatBubble(
                    imageUrl:
                        'https://gas-kvas.com/grafic/uploads/posts/2023-10/1696557271_gas-kvas-com-p-kartinki-vulkan-9.jpg',
                    chatTitle: 'GroupName',
                    secondary: 'secondaryText',),

                // Чат обычный
                ChatBubble(
                    imageUrl:
                        'https://static.wikia.nocookie.net/half-life/images/0/00/Gordonhl1.png/revision/latest/scale-to-width/360?cb=20230625151406&path-prefix=en',
                    chatTitle: 'GroupName',
                    secondary: 'secondaryText',),

                ChatBubble(
                    imageUrl:
                        'https://static.wikia.nocookie.net/half-life/images/0/00/Gordonhl1.png/revision/latest/scale-to-width/360?cb=20230625151406&path-prefix=en',
                    chatTitle: 'GroupName',
                    secondary: 'secondaryText',),
                ChatBubble(
                    imageUrl:
                        'https://static.wikia.nocookie.net/half-life/images/0/00/Gordonhl1.png/revision/latest/scale-to-width/360?cb=20230625151406&path-prefix=en',
                    chatTitle: 'GroupName',
                    secondary: 'secondaryText',),
                ChatBubble(
                    imageUrl:
                        'https://static.wikia.nocookie.net/half-life/images/0/00/Gordonhl1.png/revision/latest/scale-to-width/360?cb=20230625151406&path-prefix=en',
                    chatTitle: 'GroupName',
                    secondary: 'secondaryText',),
                ChatBubble(
                    imageUrl:
                        'https://static.wikia.nocookie.net/half-life/images/0/00/Gordonhl1.png/revision/latest/scale-to-width/360?cb=20230625151406&path-prefix=en',
                    chatTitle: 'GroupName',
                    secondary: 'secondaryText',),
                ChatBubble(
                    imageUrl:
                        'https://static.wikia.nocookie.net/half-life/images/0/00/Gordonhl1.png/revision/latest/scale-to-width/360?cb=20230625151406&path-prefix=en',
                    chatTitle: 'GroupName',
                    secondary: 'secondaryText',),
                ChatBubble(
                    imageUrl:
                        'https://static.wikia.nocookie.net/half-life/images/0/00/Gordonhl1.png/revision/latest/scale-to-width/360?cb=20230625151406&path-prefix=en',
                    chatTitle: 'GroupName',
                    secondary: 'secondaryText',),
                ChatBubble(
                    imageUrl:
                        'https://static.wikia.nocookie.net/half-life/images/0/00/Gordonhl1.png/revision/latest/scale-to-width/360?cb=20230625151406&path-prefix=en',
                    chatTitle: 'GroupName',
                    secondary: 'secondaryText',),
                ChatBubble(
                    imageUrl:
                        'https://static.wikia.nocookie.net/half-life/images/0/00/Gordonhl1.png/revision/latest/scale-to-width/360?cb=20230625151406&path-prefix=en',
                    chatTitle: 'GroupName',
                    secondary: 'secondaryText',),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
