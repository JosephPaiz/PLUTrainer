import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/widgets/Home/chart_text_menu.dart';
import 'package:plu_trainer/widgets/Home/doughnut_chart.dart';

class ChartMenu extends StatefulWidget {
  const ChartMenu({super.key});

  @override
  State<ChartMenu> createState() => _ChartMenuState();
}

class _ChartMenuState extends State<ChartMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
        width: 600,
        height: 400,
        decoration: BoxDecoration(
          color: CustomColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DoughnutChart(),
              SizedBox(width: 40),
              ChartTextMenu(),
            ],
          ),
        ),
      ),
    );
  }
}
