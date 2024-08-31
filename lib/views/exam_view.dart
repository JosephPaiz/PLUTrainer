import 'package:flutter/material.dart';
import 'package:plu_trainer/widgets/Training/PLUListView/plulist_menu.dart';
import 'package:plu_trainer/widgets/Training/PLUTextField/plutextfield_bar.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:provider/provider.dart';

class ExamView extends StatefulWidget {
  const ExamView({super.key});

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final timerViewModel = Provider.of<TimerViewModel>(context);
    return Container(
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(30),
            child: ExamSelectionBarMenu(),
          ),
          const PLUListMenu(),
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
    );
  }
}
