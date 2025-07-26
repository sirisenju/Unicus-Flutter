import 'package:flutter/material.dart';
import 'propertycard.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavBar(selectedIndex: 0),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome Favour", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text("Here's an overview of your dashboard"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.notifications_none),
                      SizedBox(width: 12),
                      Icon(Icons.settings),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              SizedBox(height: 20),
              // CategoryIcons(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recommendation", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text("See All", style: TextStyle(color: Colors.blue)),
                ],
              ),
              SizedBox(height: 10),
              PropertyCard(
                title: 'Premium Land 24',
                price: '\$24,563',
                location: 'Abuja area 22',
                details: '100x100 • Flat • Cleared',
                imageUrl: 'https://i.imgur.com/lPZdjBu.jpg',
              ),
              SizedBox(height: 20),
              Text("Owned Properties", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              PropertyCard(
                title: 'Premium Land 24',
                price: '\$24,563',
                location: 'Abuja area 22',
                details: '100x100 • 15 Apartments • Garage',
                imageUrl: 'https://i.imgur.com/8UG3SXX.jpg',
                status: 'Active for Sale',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
