import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';

class HistoryButtonSelectMode extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const HistoryButtonSelectMode({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SideBarButtonState createState() => _SideBarButtonState();
}

class _SideBarButtonState extends State<HistoryButtonSelectMode> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: 180,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: widget.isSelected
                    ? CustomColors.darkGreen
                    : _isHovered
                        ? CustomColors.grey
                        : CustomColors.white,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: CustomColors.darkGreen, width: 2)),
            child: Center(
              child: Text(widget.text, style: TextStyle(fontSize: 15)),
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
