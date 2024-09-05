import 'package:flutter/material.dart';
import 'package:plu_trainer/core/localization/plutrainer_localizations_esp.dart';

class RestarButton extends StatefulWidget {
  final IconData icon;
  final bool isSelectionBarOpen;
  final VoidCallback? onTap;

  const RestarButton({
    super.key,
    required this.icon,
    required this.isSelectionBarOpen,
    required this.onTap,
  });

  @override
  State<RestarButton> createState() => _SelectionbarButtonState();
}

class _SelectionbarButtonState extends State<RestarButton> {
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
          width: widget.isSelectionBarOpen ? 140 : 65,
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: ListTile(
              title: widget.isSelectionBarOpen
                  ? AnimatedDefaultTextStyle(
                      style: TextStyle(
                        fontSize: isHovered ? 14.5 : 14.0,
                        color: Colors.white,
                      ),
                      duration: const Duration(milliseconds: 300),
                      child: const Text(LocalizationsEsp.restarText),
                    )
                  : null,
              onTap: widget.onTap,
              leading: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  widget.icon,
                  color: Colors.white,
                  size: isHovered ? 26.0 : 24.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
