// import 'package:flutter/material.dart';
// import 'package:plu_trainer/widgets/History/MasterUserWidgets/history_master_profile_layout.dart';
// import 'package:plu_trainer/widgets/History/history_screen.dart';
// import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';

// class HistoryView extends StatefulWidget {
//   const HistoryView({super.key});

//   @override
//   State<HistoryView> createState() => _HistoryViewState();
// }

// class _HistoryViewState extends State<HistoryView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green,
//       body: LayoutBuilder(builder: (context, constraints) {
//         if (constraints.maxWidth < 800) {
//           return const Center(
//             child: Text(
//               'Not yet available for mobile',
//               style: TextStyle(fontSize: 20),
//             ),
//           );
//         } else {
//           return Row(
//             children: [
//               const SidebarMenu(),
//               Expanded(
//                 flex: 4,
//                 child: Container(
//                     color: const Color.fromRGBO(76, 175, 80, 1),
//                     child: HistoryScreen()),
//               )
//             ],
//           );
//         }
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:plu_trainer/widgets/History/MasterUserWidgets/history_master_profile_layout.dart';
import 'package:plu_trainer/widgets/History/history_screen.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return const Center(
            child: Text(
              'Not yet available for mobile',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          return Row(
            children: [
              const SidebarMenu(),
              Expanded(
                flex: 4,
                child: Container(
                    color: const Color.fromRGBO(76, 175, 80, 1),
                    child: const HistoryScreen()), // Usar HistoryScreen aquí
              ),
            ],
          );
        }
      }),
    );
  }
}
