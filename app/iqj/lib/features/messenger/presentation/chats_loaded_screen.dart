import 'package:flutter/material.dart';

class ChatsList extends StatefulWidget {
  const ChatsList({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  Widget _buildThumbnailImage(String image_url) {
    try {
      return Container(
        padding: EdgeInsets.only(right: 30),
        child: SizedBox(
          width: 45,
          height: 45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.network(
              image_url,
              fit: BoxFit.fill,
              height: 200,
              errorBuilder: (
                BuildContext context,
                Object exception,
                StackTrace? stackTrace,
              ) {
                return CircleAvatar(
                  radius: 6,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: const Text('A'),
                );
              },
            ),
          ),
        ),
      );
    } catch (e) {
      return Container();
    }
  }

  String? user_name = "..."; // Объявление user_name как поле класса
  String? image_url = "";

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null, "Check args");
    Map<String, dynamic> help = args as Map<String, dynamic>;
    user_name = help["name"] as String?; // Присваивание значения переменной user_name
    image_url = help["url"] as String?;

    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
                  children: [
                    _buildThumbnailImage(image_url ?? ""),
                    const Padding(padding: EdgeInsets.only(right: 12)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user_name ?? "",
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onPrimaryContainer,
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
                    Spacer(),
                    const Padding(padding: EdgeInsets.only(right: 12)),// Вставляет пространство между текстом и иконками
                    IconButton(
                      icon: Icon(Icons.phone, color: Theme.of(context).colorScheme.onBackground),
                      onPressed: () {
                        // Действие при нажатии на кнопку с телефоном
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.onBackground),
                      onPressed: () {
                        // Действие при нажатии на кнопку с тремя вертикальными точками
                      },
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: Padding(
      padding: EdgeInsets.all(8.0), // Добавляем отступы вокруг TextField
      child: TextField(
        decoration: InputDecoration(
          filled: true, // Включаем заливку цветом
          fillColor: const Color.fromARGB(255, 53, 53, 53),
          hintText: "Введите сообщение...",
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(topLeft:Radius.circular(24),topRight: Radius.circular(24)), // Закругленные углы для поля ввода
          ),
          prefixIcon: IconButton(
            icon: Icon(Icons.insert_emoticon), // Иконка смайлика
            onPressed: () {
              // Действие при нажатии на кнопку смайлика
            },
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.attach_file), // Иконка скрепки
                onPressed: () {
                  // Действие при нажатии на кнопку скрепки
                },
              ),
              IconButton(
                icon: Icon(Icons.send), 
                onPressed: () {
                  // Действие при нажатии на кнопку отправки
                },
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
