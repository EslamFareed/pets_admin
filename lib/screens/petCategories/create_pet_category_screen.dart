import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pets_admin/core/components/default_button.dart';
import 'package:pets_admin/core/components/default_text_field.dart';

class CreatePetCategoryScreen extends StatelessWidget {
  CreatePetCategoryScreen({super.key});

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Pet Category"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            DefaultTextField(
              controller: nameController,
              label: "Name",
            ),
            const SizedBox(height: 100),
            DefaultButton(
              label: "Create",
              onPressed: () async {
                FirebaseFirestore.instance.collection("petCategories").add({
                  "name": nameController.text,
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
