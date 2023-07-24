import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chatapp/common_widgets/text_fields.dart';
import 'package:firebase_chatapp/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({required this.receiverUserEmail, required this.receiverUserId, super.key});

  final String receiverUserEmail;
  final String receiverUserId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          Row(
            children: [
              Expanded(child: TextFields(hintText: "Enter Message", controller: messageController, obscureText: false)),
              IconButton(
                onPressed: () async {
                  if (messageController.text.isNotEmpty) {
                    await chatService.sendMessage(widget.receiverUserId, messageController.text);
                    messageController.clear();
                  }
                },
                icon: Icon(Icons.add),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: chatService.getMessages(widget.receiverUserId, firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading..");
        }
        return ListView(
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Text(data['senderEmail']),
          Text(data['message']),
        ],
      ),
    );
  }
}
