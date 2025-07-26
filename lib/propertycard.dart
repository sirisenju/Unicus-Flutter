import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final String title, price, location, details, imageUrl;
  final String? status;

  const PropertyCard({
    required this.title,
    required this.price,
    required this.location,
    required this.details,
    required this.imageUrl,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 20),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(location),
                SizedBox(height: 4),
                Text(details),
                SizedBox(height: 8),
                if (status != null)
                  Text(status!, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price, style: TextStyle(fontSize: 16, color: Colors.deepPurple)),
                    Row(
                      children: [
                        ElevatedButton(onPressed: () {}, child: Text("Buy Property")),
                        SizedBox(width: 8),
                        OutlinedButton(onPressed: () {}, child: Text("Chat Owner")),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
