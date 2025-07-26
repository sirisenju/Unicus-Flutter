import 'package:flutter/material.dart';
import '../widgets/propertycard.dart';
import '../widgets/owned_property_tile.dart';
import '../widgets/categoryitem.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome Favour', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Here’s an overview of your dashboard', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(child: Icon(Icons.notifications_none)),
                    SizedBox(width: 8),
                    CircleAvatar(child: Icon(Icons.settings)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                filled: true,
                fillColor: Color(0xFFF0EDFF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryItem(label: 'House', icon: Icons.apartment),
                  CategoryItem(label: 'Apartment', icon: Icons.home),
                  CategoryItem(label: 'Factory', icon: Icons.factory),
                  CategoryItem(label: 'Townhouse', icon: Icons.villa),
                  CategoryItem(label: 'Land', icon: Icons.terrain),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Recommendation', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('See All', style: TextStyle(color: Colors.deepPurple)),
              ],
            ),
            const SizedBox(height: 8),
            PropertyCard(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Owned Properties', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('See All', style: TextStyle(color: Colors.deepPurple)),
              ],
            ),
            const SizedBox(height: 8),
            const OwnedPropertyTile(),
          ],
        ),
      ),
    );
  }
}
