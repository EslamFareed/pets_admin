import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VipRequestsScreem extends StatefulWidget {
  const VipRequestsScreem({super.key});

  @override
  State<VipRequestsScreem> createState() => _VipRequestsScreemState();
}

class _VipRequestsScreemState extends State<VipRequestsScreem> {
  var isLoading = false;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  final firestore = FirebaseFirestore.instance;

  List<Map> requests = [];

  _getData() async {
    setState(() {
      isLoading = true;
    });
    var response = await firestore.collection("vipRequests").get();

    requests = response.docs
        .map((e) => {
              "id": e.id,
              "accepted": e.data()["accepted"],
              "date": e.data()["date"],
              "email": e.data()["email"],
              "name": e.data()["name"],
              "phone": e.data()["phone"],
              "userId": e.data()["userId"],
            })
        .toList();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vip Requests"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                final item = requests[index];
                return Card(
                  child: ListTile(
                    title: Text(item["name"]),
                    subtitle: Text(
                        "${item["phone"]}\n${item["email"]}\nRequest Date : ${item["date"]}\n${item["accepted"] ? "VIP" : "Normal User"}"),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        firestore
                            .collection("Users")
                            .doc(item["userId"])
                            .update({"isVip": true}).then((value) {
                          firestore
                              .collection("vipRequests")
                              .doc(item["id"])
                              .update({"accepted": true}).then((value) {
                            _getData();
                          });
                        });
                      },
                      icon: Icon(
                        item["accepted"] ? Icons.done : Icons.star,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                );
              },
              itemCount: requests.length,
            ),
    );
  }
}
