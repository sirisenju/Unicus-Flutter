import 'package:flutter/material.dart';

class OwnedPropertyTile extends StatelessWidget {
  const OwnedPropertyTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.grey.shade100,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
          width: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: const Text('Premium Land 24', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Abuja area 22'),
          Text('100x100 • 15 Apartments • Garage'),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('\$24,563', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
          Text('Active for Sale', style: TextStyle(color: Colors.green, fontSize: 12)),
        ],
      ),
    );
  }
}
