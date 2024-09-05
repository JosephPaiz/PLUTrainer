import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';

class HistoryProfileButton extends StatefulWidget {
  final String name;
  final String rol;
  final int selectColor;
  final VoidCallback onTap;
  const HistoryProfileButton(
      {super.key,
      required this.name,
      required this.rol,
      required this.selectColor,
      required this.onTap});

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
        onTap: () {
          widget.onTap();
        },
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
            duration: const Duration(milliseconds: 100),
            width: _isHovered ? 265 : 250,
            height: _isHovered ? 165 : 150,
            decoration: BoxDecoration(
                color: CustomColors
                    .backgroundHistoryProfileButton[widget.selectColor],
                borderRadius: BorderRadius.circular(20)),
            alignment: Alignment.center,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.name,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                          color: CustomColors
                              .tagHistoryProfileButton[widget.selectColor],
                          borderRadius: BorderRadius.circular(20)),
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
