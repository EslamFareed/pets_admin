import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pets_admin/core/utils/navigation_helper.dart';
import 'package:pets_admin/screens/clinics/create_clinic_screen.dart';

class ClinicsScreen extends StatelessWidget {
  ClinicsScreen({super.key});

  var firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clincs Pharamacies"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationHelper.goTo(context, const CreateClinicScreen());
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder(
        stream: firestore.collection("clincsPharamacies").snapshots(),
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
                    "id": e.id,
                    "name": e.data()["name"],
                    "picture": e.data()["picture"],
                    "location": e.data()["location"],
                    "category": e.data()["category"],
                  },
                )
                .toList();

            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(data[index]["picture"]),
                    ),
                    title: Text("name : ${data[index]["name"]}"),
                    subtitle: Text("""
location :${data[index]["location"]}\n
category :${data[index]["category"]}
                  """),
                  ),
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
