import 'package:flutter/material.dart';
import 'package:plu_trainer/widgets/Score/score_view.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';
import 'package:plu_trainer/widgets/Training/PLUListView/plulist_menu.dart';
import 'package:plu_trainer/widgets/Training/PLUTextField/plutextfield_bar.dart';
import 'package:plu_trainer/widgets/Training/SelectionBar/selectionbar_menu.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:provider/provider.dart';

class TrainingView extends StatefulWidget {
  const TrainingView({super.key});

  @override
  State<TrainingView> createState() => _TrainingViewState();
}

class _TrainingViewState extends State<TrainingView> {
  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final timerViewModel = Provider.of<TimerViewModel>(context);
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
                    color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(30),
                          child: SelectionBarMenu(),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: PLUListMenu(),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 300,
                                  child: ScoreView(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: PLUTextFiedBar(
                              onPLUEntered: timerViewModel.isTimerRunning
                                  ? (pluStr) {
                                      productViewModel.checkPLU(pluStr);
                                    }
                                  : (pluStr) {},
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          );
        }
      }),
    );
  }
}


// class _TrainingViewState extends State<TrainingView> {
//   @override
//   Widget build(BuildContext context) {
//     final productViewModel = Provider.of<ProductViewModel>(context);
//     final timerViewModel = Provider.of<TimerViewModel>(context);
//     return 
// Container(
//       color: Colors.green,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(30),
//             child: SelectionBarMenu(),
//           ),
//           const Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: PLUListMenu(),
//                   ),
//                   SizedBox(width: 10),
//                   SizedBox(
//                     width: 300,
//                     child: ScoreView(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(30),
//               child: PLUTextFiedBar(
//                 onPLUEntered: timerViewModel.isTimerRunning
//                     ? (pluStr) {
//                         productViewModel.checkPLU(pluStr);
//                       }
//                     : (pluStr) {},
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
