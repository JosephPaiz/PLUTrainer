import 'package:flutter/material.dart';

class LearningSelectionBarButton extends StatefulWidget {
  final String text;
  final bool isSeleccted;
  final VoidCallback? onTap;

  const LearningSelectionBarButton({
    super.key,
    required this.text,
    required this.isSeleccted,
    required this.onTap,
  });

  @override
  State<LearningSelectionBarButton> createState() => _SelectionbarButtonState();
}

class _SelectionbarButtonState extends State<LearningSelectionBarButton> {
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
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: widget.isSeleccted ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: ListTile(
                title: AnimatedDefaultTextStyle(
              style: TextStyle(
                fontSize: isHovered ? 17.0 : 16.0,
                color: Colors.white,
              ),
              duration: const Duration(milliseconds: 300),
              child: Text(widget.text),
            )),
          ),
        ),
      ),
    );
  }
}
