import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widgets/admin_sidebar.dart';
class PropertyScreen extends StatefulWidget {
  const PropertyScreen({super.key});

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {

  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminSidebar(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Properties", style: TextStyle(
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
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text("Properties"),
          ),
      ),

    );
  }
}
