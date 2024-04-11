import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/components/default_button.dart';
import '../../core/components/default_text_field.dart';

class CreateChatBoxOptionScreen extends StatelessWidget {
  CreateChatBoxOptionScreen({super.key});

  final nameController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Chat Box Option"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            DefaultTextField(controller: nameController, label: "Option Name"),
            const SizedBox(height: 20),
            DefaultTextField(
                controller: messageController, label: "Text Message"),
            const SizedBox(height: 50),
            DefaultButton(
              label: "Create",
              onPressed: () {
                FirebaseFirestore.instance.collection("chatBoxOptions").add({
                  "optionName": nameController.text,
                  "textMessage": messageController.text
                }).then((value) {
                  Navigator.pop(context);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
