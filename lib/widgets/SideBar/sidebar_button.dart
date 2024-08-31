import 'package:flutter/material.dart';

class SideBarButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSidebarOpen;
  final bool isSelected;
  final int index;
  final VoidCallback onTap;

  const SideBarButton({
    super.key,
    required this.icon,
    required this.text,
    required this.isSidebarOpen,
    required this.isSelected,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          border: Border.all(color: Colors.white, width: 4.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.blue,
            size: 24.0,
          ),
          title: isSidebarOpen
              ? Text(
                  text,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
