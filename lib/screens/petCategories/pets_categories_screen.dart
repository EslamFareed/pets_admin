import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_admin/core/utils/navigation_helper.dart';
import 'package:pets_admin/screens/petCategories/create_pet_category_screen.dart';

class PetCategoreisScreen extends StatelessWidget {
  PetCategoreisScreen({super.key});

  var firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Categories"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationHelper.goTo(context, CreatePetCategoryScreen());
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder(
        stream: firestore.collection("petCategories").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Map> data = [];
            data = snapshot.data!.docs
                .map((e) => {"name": e.data()["name"], "id": e.id})
                .toList();

            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                    child: Text("${index + 1}"),
                  ),
                  title: Text("name : " + data[index]["name"]),
                  subtitle: Text("id : " + data[index]["id"]),
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
