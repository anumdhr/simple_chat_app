import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chatapp/capitalize.dart';
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
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.receiverUserEmail,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
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
    var datas = data['message'];
    var capitalizedDatas = Capitalize.capitalizeSentences(datas); // Capitalize the text

    var alignment = (data['senderId'] == firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;
    var radiusL = (data['senderId'] == firebaseAuth.currentUser!.uid) ?Radius.circular(12) : Radius.circular(0);
    var radiusR = (data['senderId'] == firebaseAuth.currentUser!.uid) ?Radius.circular(0) : Radius.circular(12);
    return Container(
      alignment: alignment,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.45,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12),topRight: radiusR,topLeft: radiusL),
              color: Colors.grey            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['senderEmail'],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    decoration: TextDecoration.underline
                  ),
                ),
                Text(capitalizedDatas),
              ],
            ),
          ),
          SizedBox(height: 5,)

        ],
      ),
    );
  }
}
