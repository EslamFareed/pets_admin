import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/components/default_button.dart';
import '../../core/components/default_text_field.dart';

class CreateKnowledgeScreen extends StatefulWidget {
  CreateKnowledgeScreen({super.key});

  @override
  State<CreateKnowledgeScreen> createState() => _CreateKnowledgeScreenState();
}

class _CreateKnowledgeScreenState extends State<CreateKnowledgeScreen> {
  final nameController = TextEditingController();

  Map? chosenCategory;
  List<Map> data = [];

  _getData() async {
    await FirebaseFirestore.instance
        .collection("petCategories")
        .get()
        .then((value) {
      data = value.docs
          .map(
            (e) => {
              "name": e.data()["name"],
              "id": e.id,
            },
          )
          .toList();
    });
    setState(() {});
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Knowledge"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            DefaultTextField(
              controller: nameController,
              label: "Message",
            ),
            const SizedBox(height: 20),
            data.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : DropdownButton<Map>(
                    isExpanded: true,
                    value: chosenCategory,
                    hint: const Text("Choose Category"),
                    items: data
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e["name"]),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        chosenCategory = value;
                      });
                    },
                  ),
            const SizedBox(height: 100),
            DefaultButton(
              label: "Create",
              onPressed: () async {
                FirebaseFirestore.instance.collection("knowledges").add({
                  "text": nameController.text,
                  "categoryId": chosenCategory!["id"],
                  "categoryName": chosenCategory!["name"],
                }).then((value) {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
