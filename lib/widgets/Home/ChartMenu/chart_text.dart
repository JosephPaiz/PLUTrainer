import 'package:flutter/material.dart';

class ChartText extends StatefulWidget {
  final String percentName;
  final String percentValue;
  final Color color;

  const ChartText(
      {super.key,
      required this.percentName,
      required this.percentValue,
      required this.color});

  @override
  // ignore: library_private_types_in_public_api
  _ChartTextState createState() => _ChartTextState();
}

class _ChartTextState extends State<ChartText> {
  late String percentName;
  late String percentValue;
  late Color color;

  @override
  void initState() {
    percentName = widget.percentName;
    percentValue = widget.percentValue;
    color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$percentValue%',
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          percentName,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
