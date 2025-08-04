import 'package:flutter/material.dart';

class ChatDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chat = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(chat['name']),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // ✅ This returns to ChatScreen
          },
        ),
      ),
      body: Center(
        child: Text('Chatting with ${chat['name']}'),
      ),
    );
  }
}
