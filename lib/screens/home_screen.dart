import 'package:nms_chat_app/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final User currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00C2C0),
        title: const Center(
          child: Text(
            'My Chats',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!userSnapshot.hasData || userSnapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No one registered."));
          }

          final userDocs = userSnapshot.data!.docs;
          final otherUsers = userDocs
              .where((doc) => doc['userId'] != currentUser.uid)
              .toList();

          if (otherUsers.isEmpty) {
            return const Center(
                child: Text("No one else is available to chat."));
          }

          return ListView.builder(
            itemCount: otherUsers.length,
            itemBuilder: (ctx, index) {
              final otherUser = otherUsers[index];
              return ListTile(
                tileColor: const Color(0xFF30336B),
                title: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    otherUser['username'],
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 30,
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white, width: 5),
                  borderRadius: BorderRadius.circular(20),
                ),
                onTap: () {
                  String chatRoomId =
                      getChatRoomId(currentUser.uid, otherUser['userId']);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        chatRoomId: chatRoomId,
                        recipientId: otherUser['userId'],
                        recipientName: otherUser['username'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String getChatRoomId(String userAId, String userBId) {
    if (userAId.compareTo(userBId) < 0) {
      return '${userAId}_$userBId';
    } else {
      return '${userBId}_$userAId';
    }
  }
}
