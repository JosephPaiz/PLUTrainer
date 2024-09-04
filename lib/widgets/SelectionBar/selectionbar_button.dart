import 'package:flutter/material.dart';

class SelectionbarButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSelectionBarOpen;
  final bool isSeleccted;
  final VoidCallback? onTap;

  const SelectionbarButton({
    super.key,
    required this.icon,
    required this.text,
    required this.isSelectionBarOpen,
    required this.isSeleccted,
    required this.onTap,
  });

  @override
  State<SelectionbarButton> createState() => _SelectionbarButtonState();
}

class _SelectionbarButtonState extends State<SelectionbarButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: AnimatedContainer(
          alignment: Alignment.center,
          height: 40,
          width: widget.isSelectionBarOpen ? 130 : 65,
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: widget.isSeleccted ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: ListTile(
              title: widget.isSelectionBarOpen
                  ? AnimatedDefaultTextStyle(
                      style: TextStyle(
                        fontSize: isHovered ? 17.0 : 16.0,
                        color: Colors.white,
                      ),
                      duration: const Duration(milliseconds: 100),
                      child: Text(widget.text),
                    )
                  : null,
              onTap: widget.onTap,
              leading: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  widget.icon,
                  color: Colors.white,
                  size: isHovered ? 27.0 : 24.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
