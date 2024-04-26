import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iqj/features/messenger/data/chat_service.dart';
//import 'package:flutter_reversed_list/flutter_reversed_list.dart';
import 'package:iqj/features/messenger/presentation/screens/date_for_load_chats.dart';
import 'package:iqj/features/messenger/presentation/screens/struct_of_message.dart';

class ChatsList extends StatefulWidget {
  final String receiverUserId;
  const ChatsList({Key? key, required this.receiverUserId}) : super(key: key);
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
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
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
  bool vol = false;
  bool pin = false;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null, "Check args");
    Map<String, dynamic> help = args as Map<String, dynamic>;
    user_name =
        help["name"] as String?; // Присваивание значения переменной user_name
    image_url = help["url"] as String?;
    vol = help["volume"] as bool;
    pin = help["pin"] as bool;

    setState(() {});
    super.didChangeDependencies();
  }

  final TextEditingController _msgController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_msgController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, _msgController.text);
      _msgController.clear();
    }
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        }
        return ListView(
          reverse: true,
          children: snapshot.data!.docs
              .map((document) => _buildMessageListItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
          children: [
            Text(data['senderEmail'].toString()),
            Text(data['message'].toString())
          ],
        ));
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
                  Row(
                    children: [
                      Text(
                        user_name ?? "",
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 20,
                        ),
                      ),
                      vol ? Icon(Icons.volume_off) : Container(),
                      pin ? Icon(Icons.push_pin_outlined) : Container(),
                    ],
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
              const Padding(
                  padding: EdgeInsets.only(
                      right:
                          12)), // Вставляет пространство между текстом и иконками
              IconButton(
                icon: Icon(Icons.phone,
                    color: Theme.of(context).colorScheme.onBackground),
                onPressed: () {
                  // Действие при нажатии на кнопку с телефоном
                },
              ),
              IconButton(
                icon: Icon(Icons.more_vert,
                    color: Theme.of(context).colorScheme.onBackground),
                onPressed: () {
                  // Действие при нажатии на кнопку с тремя вертикальными точками
                },
              ),
            ],
          ),
        ),
      ),
      body: _buildMessageList(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0), // Добавляем отступы вокруг TextField
        child: TextField(
          controller: _msgController,
          decoration: InputDecoration(
            filled: true, // Включаем заливку цветом
            fillColor: Theme.of(context).colorScheme.onInverseSurface,
            hintText: "Введите сообщение...",
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight:
                      Radius.circular(24)), // Закругленные углы для поля ввода
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
                    sendMessage();
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
