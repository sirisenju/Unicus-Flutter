import 'package:flutter/material.dart';
class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(74, 67, 236, 1.0),
              ),
              child: Text('Admin Menu',  style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800
              ),),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Dashboard", style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/admin');
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add Listings", style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/add/listings');
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("All Properties", style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/properties');
              },
            ),
          ]
      ),


    );
  }
}
