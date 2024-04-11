import 'package:flutter/material.dart';
import 'package:pets_admin/screens/chatBoxOptions/chat_box_options_screen.dart';
import 'package:pets_admin/screens/clinics/clinics_screen.dart';
import 'package:pets_admin/screens/doctors/doctors_screen.dart';
import 'package:pets_admin/screens/knowledges/knowledges_screen.dart';
import 'package:pets_admin/screens/products/products_screen.dart';

import '../core/utils/navigation_helper.dart';
import 'petCategories/pets_categories_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              NavigationHelper.goTo(context, PetCategoreisScreen());
            },
            title: const Text("Pet Categories"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ),
          ListTile(
            onTap: () {
              NavigationHelper.goTo(context, ChatBoxOptionsScreen());
            },
            title: const Text("Chat Box Options"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ),
          ListTile(
            onTap: () {
              NavigationHelper.goTo(context, KnowledgesScreen());
            },
            title: const Text("knowledges"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ),
          ListTile(
            onTap: () {
              NavigationHelper.goTo(context, DoctorsScreen());
            },
            title: const Text("Doctors"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ),
          ListTile(
            onTap: () {
              NavigationHelper.goTo(context, ProductsScreen());
            },
            title: const Text("Products"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ),
          ListTile(
            onTap: () {
              NavigationHelper.goTo(context, ClinicsScreen());
            },
            title: const Text("Clinics / Pharmacies"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }
}
