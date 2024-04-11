import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/components/default_button.dart';
import '../../core/components/default_text_field.dart';

class CreateClinicScreen extends StatefulWidget {
  const CreateClinicScreen({super.key});

  @override
  State<CreateClinicScreen> createState() => _CreateClinicScreenState();
}

class _CreateClinicScreenState extends State<CreateClinicScreen> {
  final nameController = TextEditingController();

  final locationController = TextEditingController();

  XFile? image;

  String? chosenType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Clinic or Pharmacy"),
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
              controller: locationController,
              label: "Address",
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Choose Category"),
              value: chosenType,
              items: ["Clinic", "Pharmacy"]
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  chosenType = value;
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
                FirebaseFirestore.instance.collection("clincsPharamacies").add({
                  "name": nameController.text,
                  "category": chosenType,
                  "location": locationController.text,
                  "picture": imageString,
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
