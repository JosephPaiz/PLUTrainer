import 'package:flutter/material.dart';
import 'package:plu_trainer/widgets/Home/ChartMenu/chart_text.dart';

class ChartTextMenu extends StatefulWidget {
  final List<double> percentValues;
  const ChartTextMenu({super.key, required this.percentValues});

  @override
  State<ChartTextMenu> createState() => _ChartTextMenuState();
}

class _ChartTextMenuState extends State<ChartTextMenu> {
  late List<double> percentValues = [];

  @override
  void initState() {
    percentValues = widget.percentValues;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChartText(
          percentName: 'Respuestas Correctas',
          percentValue: percentValues[1].toStringAsFixed(0),
          color: Colors.green,
        ),
        const SizedBox(height: 10),
        ChartText(
          percentName: 'Respuestas Fallidas',
          percentValue: percentValues[3].toStringAsFixed(0),
          color: Colors.red,
        ),
        const SizedBox(height: 10),
        ChartText(
          percentName: 'Logro pasar',
          percentValue: percentValues[0].toStringAsFixed(0),
          color: Colors.blue,
        ),
        const SizedBox(height: 10),
        ChartText(
          percentName: 'No logro pasar',
          percentValue: percentValues[2].toStringAsFixed(0),
          color: Colors.orange,
        ),
      ],
    );
  }
}
