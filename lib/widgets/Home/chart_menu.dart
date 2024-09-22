import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/widgets/Home/chart_text_menu.dart';
import 'package:plu_trainer/widgets/Home/doughnut_chart.dart';

class ChartMenu extends StatefulWidget {
  final List<double> percentValues;
  const ChartMenu({super.key, required this.percentValues});

  @override
  State<ChartMenu> createState() => _ChartMenuState();
}

class _ChartMenuState extends State<ChartMenu> {
  late List<double> percentValues;

  @override
  void initState() {
    percentValues = widget.percentValues;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
        width: 500,
        height: 400,
        decoration: BoxDecoration(
          color: CustomColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                'Estadisticas',
                style: Fonts.charMenuTitle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DoughnutChart(
                    values: percentValues,
                  ),
                  const SizedBox(width: 0),
                  ChartTextMenu(
                    percentValues: percentValues,
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
