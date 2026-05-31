import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'destinasi_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      HomeScreen(
        onProfileTap: () {
          setState(() {
            _selectedIndex = 3;
          });
        },
      ),

      DestinasiScreen(),

      Center(
        child: Text("Favorit"),
      ),

      ProfileScreen(),
    ];
  }

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
        type: BottomNavigationBarType.fixed,

        currentIndex: _selectedIndex,

        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,

        selectedLabelStyle: const TextStyle(
          color: Colors.green,
        ),

        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
        ),

        onTap: _onItemTapped,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: "Destinasi",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorit",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}