// import 'package:flutter/material.dart';
// import 'package:plu_trainer/widgets/Home/chart_text.dart';

// class ChartTextMenu extends StatefulWidget {
//   const ChartTextMenu({super.key});

//   @override
//   State<ChartTextMenu> createState() => _ChartTextMenuState();
// }

// class _ChartTextMenuState extends State<ChartTextMenu> {
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ChartText(
//             text: 'Respuestas Correctas',
//             color: Colors.green,
//           ),
//           ChartText(
//             text: 'Respuestas Fallidas',
//             color: Colors.red,
//           ),
//           ChartText(
//             text: 'Logro pasar',
//             color: Colors.blue,
//           ),
//           ChartText(
//             text: 'No logro pasar',
//             color: Colors.orange,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:plu_trainer/widgets/Home/chart_text.dart';

class ChartTextMenu extends StatefulWidget {
  const ChartTextMenu({super.key});

  @override
  State<ChartTextMenu> createState() => _ChartTextMenuState();
}

class _ChartTextMenuState extends State<ChartTextMenu> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment:
          MainAxisAlignment.center, // Centra los textos verticalmente
      crossAxisAlignment:
          CrossAxisAlignment.start, // Alinea los textos a la izquierda
      children: [
        ChartText(
          text: 'Respuestas Correctas',
          color: Colors.green,
        ),
        SizedBox(height: 10),
        ChartText(
          text: 'Respuestas Fallidas',
          color: Colors.red,
        ),
        SizedBox(height: 10),
        ChartText(
          text: 'Logro pasar',
          color: Colors.blue,
        ),
        SizedBox(height: 10),
        ChartText(
          text: 'No logro pasar',
          color: Colors.orange,
        ),
      ],
    );
  }
}
