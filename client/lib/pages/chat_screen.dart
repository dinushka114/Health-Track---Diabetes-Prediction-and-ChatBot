import 'dart:convert';

import 'package:client/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<types.Message> _messages = [];

  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  final _userBot = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f6ha',
  );

  void onSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });

    try {
      http.Response response = await ask(message.text);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var reply = jsonResponse['response']['response'].toString();

        final replyTextMessage = types.TextMessage(
          author: _userBot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: reply,
        );

        setState(() {
          _messages.insert(0, replyTextMessage);
        });
      } else {}
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 4.0,
          title: const Text(
            "Medi chat",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
                color: Colors.white),
          ),
          backgroundColor: Colors.teal,
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Chat(
          messages: _messages,
          onSendPressed: onSendPressed,
          user: _user,
        ),
      ),
    );
  }
}
