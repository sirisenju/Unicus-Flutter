import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'screens/chat.dart';
import 'screens/listings.dart' hide ChatScreen;
import 'screens/earnings.dart' hide ChatScreen;

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(),
    ChatScreen(),
    Placeholder(), // Center FAB placeholder
    PropertiesScreen(),
    EarningsScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) return; // Ignore center FAB index
    setState(() { _selectedIndex = index;});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex > 1 ? _selectedIndex : _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.house), label: 'Properties'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Earnings'),
        ],
      ),
    );
  }
}



