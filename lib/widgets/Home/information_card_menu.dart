import 'package:flutter/material.dart';
import 'package:plu_trainer/widgets/Home/information_card_widget.dart';

class InformationCardMenu extends StatefulWidget {
  const InformationCardMenu({super.key});

  @override
  State<InformationCardMenu> createState() => _InformationCardMenuState();
}

class _InformationCardMenuState extends State<InformationCardMenu> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InformationCardWidget(
              title: 'Respuestas Correctas',
              description: 'Porcentaje de respuestas correctas',
              number: '1/10',
              backGroundColor: Color(0xFF675DF5),
              icon: Icons.check_circle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InformationCardWidget(
              title: 'Pruebas Aprobadas',
              description: 'Porcentaje de pruebas aprobadas',
              number: '1/10',
              backGroundColor: Colors.green,
              icon: Icons.remove_circle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InformationCardWidget(
              title: 'Tiempo de Cada Prueba',
              description: 'Porcentaje de tiempo por prueba',
              number: '30S',
              backGroundColor: Colors.orange,
              icon: Icons.incomplete_circle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InformationCardWidget(
              title: 'Tiempo por Pregunta',
              description: 'Porcentaje tiempo por pregunta',
              number: '2S',
              backGroundColor: Colors.red,
              icon: Icons.swap_horizontal_circle,
            ),
          ),
        ],
      ),
    );
  }
}
