import 'package:flutter/material.dart';
import 'package:e_commerce_app/components/buttom_navbar.dart'; // Dosya ismin bu şekildeydi
import 'package:e_commerce_app/views/card_screen.dart';
import 'package:e_commerce_app/views/favorite_screen.dart';
import 'package:e_commerce_app/views/home_screen.dart';
import 'package:e_commerce_app/views/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const CardScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      
      bottomNavigationBar: ButtomNavbar(
        selectedIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; 
          });
        },
      ),
    );
  }
}