import 'package:flutter/material.dart';
class PropertyCard extends StatelessWidget {
  final String price;
  final String locationDetails;
  final String imageUrl;

  const PropertyCard({
    Key? key,
    required this.price,
    required this.locationDetails,
    required this.imageUrl,
  }) : super(key: key);

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
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(price, style: TextStyle(color: Colors.deepPurple)),
          ],
        ),
        Text(locationDetails, style: TextStyle(color: Colors.grey)),
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
