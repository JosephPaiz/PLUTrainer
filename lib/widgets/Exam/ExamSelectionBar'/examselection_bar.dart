import 'package:flutter/material.dart';
import 'package:plu_trainer/Widgets/contract_button.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:plu_trainer/widgets/Training/SelectionBar/playstop_button.dart';
import 'package:plu_trainer/viewmodels/Training/playstop_button_view_model.dart.dart';
import 'package:provider/provider.dart';

class ExamSelectionBarMenu extends StatefulWidget {
  const ExamSelectionBarMenu({super.key});

  @override
  State<ExamSelectionBarMenu> createState() => _ExamSelectionBarMenuState();
}

class _ExamSelectionBarMenuState extends State<ExamSelectionBarMenu> {
  bool selectionBarIsOpen = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final timerViewModel = Provider.of<TimerViewModel>(context);
    final productViewModel = Provider.of<ProductViewModel>(context);
    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context);

    timerViewModel.onTimerEnd = () {
      productViewModel.fetchRandomProducts();
      playStopButtonViewModel.stopPlaying();
    };
  }

  @override
  Widget build(BuildContext context) {
    final timerViewModel = Provider.of<TimerViewModel>(context);
    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 50,
      width: selectionBarIsOpen ? MediaQuery.of(context).size.width : 400,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ContractButton(
              onTap: () {
                setState(() {
                  selectionBarIsOpen = !selectionBarIsOpen;
                });
              },
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlayStopButton(
                  isSelectionBarOpen: selectionBarIsOpen,
                  isPlaying: playStopButtonViewModel.isPlaying,
                  onTap: playStopButtonViewModel.isPlaying
                      ? () {
                          playStopButtonViewModel.togglePlayStop();
                          timerViewModel.stopTimer();
                        }
                      : () {
                          playStopButtonViewModel.togglePlayStop();
                          timerViewModel.startTimer();
                        },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
