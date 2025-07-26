import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recommendation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Container(
          height: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1560185127-6ed189bf019d'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Premium Land 24', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('\$24,563', style: TextStyle(color: Colors.deepPurple)),
          ],
        ),
        Text('Abuja area 22 • 100x100 • Flat • Cleared', style: TextStyle(color: Colors.grey)),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(onPressed: () {}, child: Text('Buy Property')),
            ),
            SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(onPressed: () {}, child: Text('Chat Owner')),
            ),
          ],
        )
      ],
    );
  }
}
