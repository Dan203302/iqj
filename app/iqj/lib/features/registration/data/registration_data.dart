import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> sendData(String email, String surname, String name, String patr, String role, String password) async{
  final response = await http.get(
    Uri(
      scheme: 'https',
      host: 'mireaiqj.ru',
      port: 8443,
      path: '/sign-up',
    ),
  );
  String fio = surname + ' ' + name + ' ' + patr;
  json.encode({'name': fio, 'role': role, 'data': {'email': email, 'password': password}, 'bio': ''});
  if (response.statusCode == 200){
    return json.decode(response.body);
  } else {
    throw Exception('Ошибка');
  }
}