import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'screens/chat.dart';
import 'screens/listings.dart';
import 'screens/earnings.dart';

class BottomNav extends StatefulWidget {
  final int initialIndex;
  const BottomNav({super.key, this.initialIndex = 0});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int _selectedIndex;

  @override

  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    DashboardScreen(),
    ChatScreen(),
    PropertiesScreen(),
    EarningsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
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
