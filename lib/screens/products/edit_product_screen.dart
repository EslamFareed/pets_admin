import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets_admin/core/components/default_text_field.dart';

import '../../core/components/default_button.dart';

class EditProductScreen extends StatefulWidget {
  EditProductScreen({super.key, required this.item});

  Map item;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final nameController = TextEditingController();

  final priceController = TextEditingController();

  final descController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.item["name"];
    priceController.text = widget.item["price"];
    descController.text = widget.item["desc"];
    super.initState();
  }

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
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
              controller: descController,
              label: "Description",
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: priceController,
                decoration: InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
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
                          .collection("products")
                          .doc(widget.item["id"])
                          .update({
                        "name": nameController.text,
                        "desc": descController.text,
                        "price": priceController.text,
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
