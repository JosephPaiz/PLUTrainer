import 'package:flutter/material.dart';

class ChartText extends StatefulWidget {
  final String text;
  final Color color;

  const ChartText({super.key, required this.text, required this.color});

  @override
  _ChartTextState createState() => _ChartTextState();
}

class _ChartTextState extends State<ChartText> {
  late String text;
  late Color color;

  @override
  void initState() {
    text = widget.text;
    color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
