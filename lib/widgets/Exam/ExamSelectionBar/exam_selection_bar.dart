import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:plu_trainer/Widgets/contract_button.dart';
import 'package:plu_trainer/viewmodels/Exam/exam_plu_list_image_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/widgets/Training/SelectionBar/playstop_button.dart';
import 'package:plu_trainer/viewmodels/Training/playstop_button_view_model.dart.dart';
import 'package:plu_trainer/widgets/Training/SelectionBar/restar_button.dart';
import 'package:provider/provider.dart';

class ExamSelectionBar extends StatefulWidget {
  const ExamSelectionBar({super.key});

  @override
  State<ExamSelectionBar> createState() => _ExamSelectionBarState();
}

class _ExamSelectionBarState extends State<ExamSelectionBar> {
  bool selectionBarIsOpen = true;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final timerViewModel = Provider.of<TimerViewModel>(context, listen: false);
    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context);
    final examPluListImageViewModel =
        Provider.of<ExamPluListImageViewModel>(context);

    timerViewModel.onTimerEnd = () {
      timerViewModel.stopTimer();
      playStopButtonViewModel.stopPlaying();
    };

    examPluListImageViewModel.connectToTimer(timerViewModel);

    if (examPluListImageViewModel.showScore) {
      examPluListImageViewModel.checkResultsLength();
      timerViewModel.stopTimer();
      playStopButtonViewModel.stopPlaying();
    }

    if (!_isInitialized) {
      timerViewModel.initializeTimer(120);
      _isInitialized = true;
    }
  }
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final timerViewModel = Provider.of<TimerViewModel>(context, listen: false);
  //   final productViewModel = Provider.of<ProductViewModel>(context);
  //   final playStopButtonViewModel =
  //       Provider.of<PlayStopButtonViewModel>(context);

  //   timerViewModel.onTimerEnd = () {
  //     timerViewModel.stopTimer();
  //     playStopButtonViewModel.stopPlaying();
  //   };
  //   productViewModel.connectToTimer(timerViewModel);

  //   if (productViewModel.showScore) {
  //     productViewModel.checkResultsLength();
  //     timerViewModel.stopTimer();
  //     playStopButtonViewModel.stopPlaying();
  //   }

  //   if (!_isInitialized) {
  //     timerViewModel.initializeTimer(120);
  //     _isInitialized = true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final timerViewModel = Provider.of<TimerViewModel>(context);
    final pluHelperViewModel = Provider.of<PLUHelperViewModel>(context);
    final examPluListImageViewModel =
        Provider.of<ExamPluListImageViewModel>(context);

    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 50,
      width: selectionBarIsOpen ? 500 : 250,
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
                ),
                RestarButton(
                    icon: HugeIcons.strokeRoundedReload,
                    isSelectionBarOpen: selectionBarIsOpen,
                    onTap: () {
                      examPluListImageViewModel.resetButton();
                      timerViewModel.resetTimer();
                      pluHelperViewModel.resetPluHelperUsage();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
