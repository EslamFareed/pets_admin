import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/components/default_button.dart';
import '../../core/components/default_text_field.dart';

class EditClinicScreen extends StatefulWidget {
  EditClinicScreen({super.key, required this.item});

  Map item;

  @override
  State<EditClinicScreen> createState() => _EditClinicScreenState();
}

class _EditClinicScreenState extends State<EditClinicScreen> {
  final nameController = TextEditingController();

  final locationController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.item["name"];
    locationController.text = widget.item["location"];
    super.initState();
  }

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Clinic or Pharmacy"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
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
                          .collection("clincsPharamacies")
                          .doc(widget.item["id"])
                          .update({
                        "name": nameController.text,
                        "location": locationController.text,
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
