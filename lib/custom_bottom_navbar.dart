import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<NavItemData> items = [
      NavItemData(icon: Icons.home_rounded, label: 'Home'),
      NavItemData(icon: Icons.search_rounded, label: 'Explore'),
      NavItemData(icon: Icons.favorite_rounded, label: 'Saved'),
      NavItemData(icon: Icons.settings_rounded, label: 'Settings'),
    ];

    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Container(
      height: isTablet ? 80 : 65,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = currentIndex == index;
          final item = items[index];

          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 16 : 12,
                vertical: isSelected ? 10 : 8,
              ),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      item.icon,
                      size: isTablet ? 32 : 24,
                      color: isSelected ? Colors.blueAccent : Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    style: TextStyle(
                      fontSize: isTablet ? 14 : 12,
                      color: isSelected ? Colors.blueAccent : Colors.grey,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                    ),
                    child: Text(item.label),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class NavItemData {
  final IconData icon;
  final String label;

  NavItemData({required this.icon, required this.label});
}
