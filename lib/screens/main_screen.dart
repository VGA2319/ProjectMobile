import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'destinasi_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
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

      const FavoriteScreen(),

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