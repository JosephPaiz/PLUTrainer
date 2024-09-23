import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';

class HistoryProfileButton extends StatefulWidget {
  final String name;
  final String rol;
  final int selectColor;
  final VoidCallback onTap;

  const HistoryProfileButton({
    super.key,
    required this.name,
    required this.rol,
    required this.selectColor,
    required this.onTap,
  });

  @override
  State<HistoryProfileButton> createState() => _HistoryProfileButtonState();
}

class _HistoryProfileButtonState extends State<HistoryProfileButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHovered = false;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 130),
            width: _isHovered ? 255 : 250,
            height: _isHovered ? 155 : 150,
            decoration: BoxDecoration(
              color: CustomColors.white,
              border: Border.all(color: CustomColors.darkGreen, width: 1.0),
              borderRadius: BorderRadius.circular(20),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 70,
                    decoration: const BoxDecoration(
                      color: CustomColors.darkGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 15, color: CustomColors.white),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomColors.deepRed,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.rol,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
