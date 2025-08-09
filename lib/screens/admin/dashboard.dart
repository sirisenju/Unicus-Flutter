import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_class_git/widgets/custom.selected.button.dart';
import 'package:flutter_class_git/widgets/custom.textfield.widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../main.dart';
import '../../widgets/admin_sidebar.dart';
// import 'package:image/image.dart' as img;
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {


  //logout function
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

      // sidebar

      drawer: AdminSidebar(),

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Admin Dashboard", style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),),
        actions: [
          GestureDetector(
            onTap: () {
              logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const CircleAvatar(child: Icon(Icons.logout)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Welcome Admin", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900

                ),)
              ],
            ),
        ),
      ),
    );
  }
}
