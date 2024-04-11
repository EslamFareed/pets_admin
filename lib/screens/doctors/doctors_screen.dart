import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pets_admin/core/utils/navigation_helper.dart';
import 'package:pets_admin/screens/doctors/create_doctor_screen.dart';

class DoctorsScreen extends StatelessWidget {
  DoctorsScreen({super.key});

  var firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationHelper.goTo(context, CreateDoctorScreen());
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder(
        stream: firestore.collection("doctors").snapshots(),
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
                    "address": e.data()["address"],
                    "id": e.id,
                    "name": e.data()["name"],
                    "picture": e.data()["picture"],
                    "rate": e.data()["rate"],
                    "specialization": e.data()["specialization"],
                    "type": e.data()["type"],
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
specialization :${data[index]["specialization"]}\n
type :${data[index]["type"]}\n
address :${data[index]["address"]}\n
rate :${data[index]["rate"]}\n
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
