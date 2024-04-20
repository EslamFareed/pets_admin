import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/components/default_button.dart';
import '../../core/components/default_text_field.dart';

class EditKnowledgeScreen extends StatefulWidget {
  EditKnowledgeScreen({super.key, required this.item});

  Map item;

  @override
  State<EditKnowledgeScreen> createState() => _EditKnowledgeScreenState();
}

class _EditKnowledgeScreenState extends State<EditKnowledgeScreen> {
  final nameController = TextEditingController();

  var loading = false;

  @override
  void initState() {
    nameController.text = widget.item["text"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Knowledge"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            DefaultTextField(
              controller: nameController,
              label: "Message",
            ),
            const SizedBox(height: 100),
            loading
                ? const Center(child: CircularProgressIndicator())
                : DefaultButton(
                    label: "Save Data",
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      FirebaseFirestore.instance
                          .collection("knowledges")
                          .doc(widget.item["id"])
                          .update({
                        "text": nameController.text,
                      }).then((value) {
                        Navigator.pop(context);
                      });
                      setState(() {
                        loading = false;
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
