import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pets_admin/core/components/default_button.dart';
import 'package:pets_admin/core/components/default_text_field.dart';
import 'package:pets_admin/screens/chatBoxOptions/create_chat_box_option_screen.dart';

import '../../core/utils/navigation_helper.dart';

class ChatBoxOptionsScreen extends StatelessWidget {
  ChatBoxOptionsScreen({super.key});
  var firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Box Options"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationHelper.goTo(context, CreateChatBoxOptionScreen());
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder(
        stream: firestore.collection("chatBoxOptions").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Map> data = [];
            data = snapshot.data!.docs
                .map((e) => {
                      "optionName": e.data()["optionName"],
                      "textMessage": e.data()["textMessage"],
                      "id": e.id,
                    })
                .toList();
            return ListView.builder(
              itemBuilder: (context, index) {
                print(data[index]["id"]);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                    child: Text("${index + 1}"),
                  ),
                  title: Text("optionName : " + data[index]["optionName"]),
                  subtitle: Text("textMessage : " + data[index]["textMessage"]),
                );
              },
              itemCount: data.length,
            );
          }
        },
      ),
    );
  }
}
