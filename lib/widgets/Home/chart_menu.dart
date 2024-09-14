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
      padding: EdgeInsets.all(30),
      child: Container(
        width: 600,
        height: 400,
        decoration: BoxDecoration(
          color: CustomColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centra en el eje horizontal
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centra en el eje vertical
            children: [
              DoughnutChart(),
              SizedBox(width: 40), // Espacio entre el gráfico y el texto
              const ChartTextMenu(),
            ],
          ),
        ),
      ),
    );
  }
}
