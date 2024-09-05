import 'package:flutter/material.dart';
import 'package:plu_trainer/core/localization/plutrainer_localizations_esp.dart';

class LogoutButton extends StatefulWidget {
  final bool isSelectionBarOpen;
  final VoidCallback? onTap;

  const LogoutButton({
    super.key,
    required this.isSelectionBarOpen,
    required this.onTap,
  });

  @override
  State<LogoutButton> createState() => _SelectionbarButtonState();
}

class _SelectionbarButtonState extends State<LogoutButton> {
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
          child: Container(
            decoration: BoxDecoration(color: Colors.red[900]),
            child: Text('Cerrar Sesión'),
          )),
    );
  }
}
