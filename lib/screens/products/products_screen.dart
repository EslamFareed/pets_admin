import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pets_admin/core/utils/navigation_helper.dart';
import 'package:pets_admin/screens/products/create_product_screen.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});

  var firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationHelper.goTo(context, CreateProductScreen());
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder(
        stream: firestore.collection("products").snapshots(),
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
                    "category": e.data()["category"],
                    "id": e.id,
                    "name": e.data()["name"],
                    "picture": e.data()["picture"],
                    "desc": e.data()["desc"],
                    "price": e.data()["price"],
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
category :${data[index]["category"]}\n
desc :${data[index]["desc"]}\n
price :${data[index]["price"]}
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
