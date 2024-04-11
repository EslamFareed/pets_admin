import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pets_admin/core/utils/navigation_helper.dart';
import 'package:pets_admin/screens/knowledges/create_knowledge_screen.dart';

class KnowledgesScreen extends StatelessWidget {
  KnowledgesScreen({super.key});

  var firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Knowledges"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationHelper.goTo(context, CreateKnowledgeScreen());
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder(
        stream: firestore.collection("knowledges").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Map> data = [];

            data = snapshot.data!.docs
                .map(
                  (e) => {
                    "text": e.data()["text"],
                    "id": e.id,
                    "categoryId": e.data()["categoryId"],
                    "categoryName": e.data()["categoryName"],
                  },
                )
                .toList();

            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                    child: Text("${index + 1}"),
                  ),
                  title: Text("categoryName : " + data[index]["categoryName"]),
                  subtitle: Text("text : " + data[index]["text"]),
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
