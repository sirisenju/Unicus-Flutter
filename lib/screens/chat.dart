// import 'package:flutter/material.dart';
//
// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text('Chat Screen'));
//   }
// }
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Agent blabla',
      'lastMessage': 'investments from the past',
      'time': '10:45 AM',
      'avatar': 'https://example.com/avatar1.jpg',
    },
    {
      'name': 'Agent Special one',
      'lastMessage': 'new listings',
      'time': '9:20 AM',
      'avatar': 'https://example.com/avatar2.jpg',
    },
    // add more chats
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chats')),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat['avatar']),
            ),
            title: Text(chat['name']),
            subtitle: Text(chat['lastMessage']),
            trailing: Text(chat['time']),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/chat',
                arguments: chat, // You can pass chat ID or agent info here
              );
            },
          );
        },
      ),
    );
  }
}
