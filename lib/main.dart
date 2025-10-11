import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('HTTP POST Example')),
        body: const Center(child: PostButton()),
      ),
    );
  }
}

class PostButton extends StatelessWidget {
  const PostButton({super.key});

  Future<void> _sendPostRequest() async {
    final url = Uri.https('httpbin.org','/post');
    final data = {'name': 'Flutter USer', 'message': 'Hello from Flutter'};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Успех: ${response.body}');
    }
    else{
      print('Ошибка: ${response.statusCode}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: _sendPostRequest, 
    child: const Text('Отрпавить POST-запрос'),
    );
  }
}