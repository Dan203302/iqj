import 'package:flutter/material.dart';

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
            ? Container(
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
                          horizontal: 12, vertical: 10,),
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
                        Theme.of(context).colorScheme.primaryContainer,),
                  ),
                  child: const Text('Все'),
                ),
                const Padding(padding: EdgeInsets.only(right: 6)),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.onSurface,),
                    //backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
                  ),
                  child: const Text('Группы'),
                ),
                const Padding(padding: EdgeInsets.only(right: 6)),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.onSurface,),
                    //backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
                  ),
                  child: const Text('Студенты'),
                ),
                const Padding(padding: EdgeInsets.only(right: 6)),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.onSurface,),
                    //backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
                  ),
                  child: const Text('Преподаватели'),
                ),
                const Padding(padding: EdgeInsets.only(right: 6)),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.onSurface,),
                    //backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
                  ),
                  child: const Text('Руководство'),
                ),
                const Padding(padding: EdgeInsets.only(right: 6)),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.onSurface,),
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
              children: [

                // Чат текущей пары
                Container(
                  margin: const EdgeInsets.only(right: 12, left: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primaryContainer,
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 12, left: 12, right: 12, bottom: 12,),
                      padding: const EdgeInsets.only(
                        left: 3,
                        right: 3,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Текущая пара",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 26,
                                ),
                              ),
                              Text(
                                "до 15:50",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12)),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  'https://gas-kvas.com/grafic/uploads/posts/2023-10/1696557271_gas-kvas-com-p-kartinki-vulkan-9.jpg',
                                  fit: BoxFit.fill,
                                  height: 64,
                                  width: 64,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace,) {
                                    return Container();
                                  },
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(right: 12)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ЯЮБО-02-23",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Павел К. печатает...",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.only(right: 12,)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 18)),

                // Чат обычный
                Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                      surfaceTintColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.background,
                      ),
                      shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 12, left: 12, right: 12, bottom: 12,),
                      padding: const EdgeInsets.only(
                        left: 3,
                        right: 3,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              'https://static.wikia.nocookie.net/half-life/images/0/00/Gordonhl1.png/revision/latest/scale-to-width/360?cb=20230625151406&path-prefix=en',
                              fit: BoxFit.fill,
                              height: 64,
                              width: 64,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace,) {
                                return Container();
                              },
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 12)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "А. Б. Веселухов",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "печатает...",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(right: 12)),
                        ],
                      ),
                    ),
                  ),
                ),

                const Padding(padding: EdgeInsets.only(bottom: 6)),

                // Чат обычный
                Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                      surfaceTintColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.background,
                      ),
                      shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 12, left: 12, right: 12, bottom: 12,),
                      padding: const EdgeInsets.only(
                        left: 3,
                        right: 3,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              'https://cdn.britannica.com/22/215522-131-FB1512ED/green-grass-close-up.jpg',
                              fit: BoxFit.fill,
                              height: 64,
                              width: 64,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace,) {
                                return Container();
                              },
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 12)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Потрогай травку",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Вы: возьми больничный",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(right: 12)),
                        ],
                      ),
                    ),
                  ),
                ),

                const Padding(padding: EdgeInsets.only(bottom: 6)),

                // Чат обычный
                Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                      surfaceTintColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.background,
                      ),
                      shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 12, left: 12, right: 12, bottom: 12,),
                      padding: const EdgeInsets.only(
                        left: 3,
                        right: 3,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              'https://gas-kvas.com/grafic/uploads/posts/2023-10/1696557271_gas-kvas-com-p-kartinki-vulkan-9.jpg',
                              fit: BoxFit.fill,
                              height: 64,
                              width: 64,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace,) {
                                return Container();
                              },
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 12)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ЯЮБО-02-23",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Павел К. печатает...",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(right: 12)),
                        ],
                      ),
                    ),
                  ),
                ),

                const Padding(padding: EdgeInsets.only(bottom: 6)),

                // Чат обычный
                Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                      surfaceTintColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.background,
                      ),
                      shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 12, left: 12, right: 12, bottom: 12,),
                      padding: const EdgeInsets.only(
                        left: 3,
                        right: 3,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              'https://gas-kvas.com/grafic/uploads/posts/2023-10/1696557271_gas-kvas-com-p-kartinki-vulkan-9.jpg',
                              fit: BoxFit.fill,
                              height: 64,
                              width: 64,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace,) {
                                return Container();
                              },
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 12)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ЯЮБО-02-23",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Павел К. печатает...",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(right: 12)),
                        ],
                      ),
                    ),
                  ),
                ),

                const Padding(padding: EdgeInsets.only(bottom: 6)),

                // Чат обычный
                Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                      surfaceTintColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.background,
                      ),
                      shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 12, left: 12, right: 12, bottom: 12,),
                      padding: const EdgeInsets.only(
                        left: 3,
                        right: 3,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              'https://gas-kvas.com/grafic/uploads/posts/2023-10/1696557271_gas-kvas-com-p-kartinki-vulkan-9.jpg',
                              fit: BoxFit.fill,
                              height: 64,
                              width: 64,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace,) {
                                return Container();
                              },
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 12)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ЯЮБО-02-23",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Павел К. печатает...",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(right: 12)),
                        ],
                      ),
                    ),
                  ),
                ),

                const Padding(padding: EdgeInsets.only(bottom: 6)),

                // Чат обычный
                Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                      surfaceTintColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.background,
                      ),
                      shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 12, left: 12, right: 12, bottom: 12,),
                      padding: const EdgeInsets.only(
                        left: 3,
                        right: 3,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              'https://i.pinimg.com/564x/85/0b/0d/850b0dcb658e77b680e67829961f4ebd.jpg',
                              fit: BoxFit.fill,
                              height: 64,
                              width: 64,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace,) {
                                return Container();
                              },
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 12)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "тимбилдинг",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Игорь С. печатает...",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(right: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 6)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
