import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';

class DoughnutChart extends StatefulWidget {
  const DoughnutChart({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DoughnutChartState createState() => _DoughnutChartState();
}

class _DoughnutChartState extends State<DoughnutChart> {
  // List<double> values = [40, 30, 20, 10];
  List<double> values = [40, 30, 10, 20];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: PieChart(
        PieChartData(
          sections: showingSections(),
          centerSpaceRadius: 80,
          sectionsSpace: 5,
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    if (values.every((value) => value == 0)) {
      return [
        PieChartSectionData(
          color: Colors.grey,
          value: 100,
          title: '',
          radius: 50,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ];
    }

    return List.generate(4, (i) {
      const double fontSize = 16;
      const double radius = 50;

      return PieChartSectionData(
        color: getColor(i),
        value: values[i],
        title: '${values[i]}%',
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }

  Color getColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
