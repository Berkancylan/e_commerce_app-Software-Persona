import 'package:flutter/material.dart';

class ButtomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const ButtomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, 
        children: [
          _buildNavItem(0, Icons.home_rounded, 'Ana Sayfa'),
          _buildNavItem(1, Icons.favorite_rounded, 'Favoriler'),
          _buildNavItem(2, Icons.shopping_bag_outlined, 'Sepetim'),
          _buildNavItem(3, Icons.person_rounded, 'Profil'),
        ],
      ),
    );
  }
  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = selectedIndex == index;
    
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque, 
      child: SizedBox(
        height: 65, 
        width: 60,  
        child: Icon(
          icon,
          size: 25, 
          color: isSelected ? Colors.black : Colors.grey.shade400,
        ),
      ),
    );
  }
}