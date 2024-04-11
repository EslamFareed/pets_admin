import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets_admin/core/components/default_text_field.dart';

import '../../core/components/default_button.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final nameController = TextEditingController();

  final priceController = TextEditingController();

  final descController = TextEditingController();

  XFile? image;

  String? chosenCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Product"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            image == null
                ? DefaultButton(
                    label: "Choose Image",
                    onPressed: () async {
                      image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      setState(() {});
                    },
                  )
                : CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(File(image!.path)),
                  ),
            const SizedBox(height: 10),
            DefaultTextField(
              controller: nameController,
              label: "Name",
            ),
            const SizedBox(height: 10),
            DefaultTextField(
              controller: descController,
              label: "Description",
            ),
            const SizedBox(height: 10),
            DefaultTextField(
              controller: priceController,
              label: "Price",
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Choose Category"),
              value: chosenCategory,
              items: ["Medication", "Food", "Other"]
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
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
                final storageRef = FirebaseStorage.instance.ref();
                final mountainImagesRef =
                    storageRef.child("images/${image!.name}");
                String imageString = "";
                try {
                  var response =
                      await mountainImagesRef.putFile(File(image!.path));

                  imageString = await response.ref.getDownloadURL();
                } catch (e) {
                  print(e.toString());
                  // ...
                }
                FirebaseFirestore.instance.collection("products").add({
                  "name": nameController.text,
                  "category": chosenCategory,
                  "desc": descController.text,
                  "picture": imageString,
                  "price": priceController.text,
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
