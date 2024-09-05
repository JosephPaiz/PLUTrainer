import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/fonts.dart';

class SideBarButton extends StatefulWidget {
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
  // ignore: library_private_types_in_public_api
  _SideBarButtonState createState() => _SideBarButtonState();
}

class _SideBarButtonState extends State<SideBarButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? Colors.green
                : _isHovered
                    ? Colors.grey.shade300
                    : Colors.white,
            border: Border.all(color: Colors.white, width: 4.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: ListTile(
              leading: Icon(
                widget.icon,
                color: widget.isSelected ? Colors.white : Colors.blue,
                size: 24.0,
              ),
              title: widget.isSidebarOpen
                  ? Text(widget.text,
                      style: widget.isSelected
                          ? Fonts.sideBarButtonTextStyleActive
                          : Fonts.sideBarButtonTextStyledesactive

                      //  TextStyle(
                      //   color: widget.isSelected ? Colors.white : Colors.grey,
                      // ),
                      )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}
