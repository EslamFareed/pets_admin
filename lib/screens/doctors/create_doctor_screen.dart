import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/components/default_button.dart';
import '../../core/components/default_text_field.dart';

class CreateDoctorScreen extends StatefulWidget {
  const CreateDoctorScreen({super.key});

  @override
  State<CreateDoctorScreen> createState() => _CreateDoctorScreenState();
}

class _CreateDoctorScreenState extends State<CreateDoctorScreen> {
  final nameController = TextEditingController();

  final addressController = TextEditingController();

  final rateController = TextEditingController();

  final specializationController = TextEditingController();

  XFile? image;

  String? chosenType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Doctor"),
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
              controller: addressController,
              label: "Address",
            ),
            const SizedBox(height: 10),
            DefaultTextField(
              controller: rateController,
              label: "Rate",
            ),
            const SizedBox(height: 10),
            DefaultTextField(
              controller: specializationController,
              label: "Specialization",
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Choose Type"),
              value: chosenType,
              items: ["from home", "on site"]
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
                FirebaseFirestore.instance.collection("doctors").add({
                  "name": nameController.text,
                  "type": chosenType,
                  "address": addressController.text,
                  "picture": imageString,
                  "rate": rateController.text,
                  "specialization": specializationController.text,
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
