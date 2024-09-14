import 'package:flutter/material.dart';

class InformationCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final String number;
  final Color backGroundColor;
  final IconData icon;

  const InformationCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.number,
    required this.backGroundColor,
    required this.icon,
  });

  @override
  _InformationCardWidgetState createState() => _InformationCardWidgetState();
}

class _InformationCardWidgetState extends State<InformationCardWidget> {
  late String title;
  late String description;
  late String number;
  late Color backGroundColor;
  late IconData icon;

  // Variable para controlar si está en hover
  bool isHovering = false;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    description = widget.description;
    number = widget.number;
    backGroundColor = widget.backGroundColor;
    icon = widget.icon;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovering = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: isHovering ? 260 : 250,
        height: isHovering ? 180 : 170,
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isHovering
              ? [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  )
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    number,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: backGroundColor, // Color del ícono
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
