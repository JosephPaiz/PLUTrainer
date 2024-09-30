import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:plu_trainer/Widgets/contract_button.dart';
import 'package:plu_trainer/viewmodels/Exam/exam_alert_dialog_access_view_model.dart';
import 'package:plu_trainer/viewmodels/Exam/exam_plu_list_image_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/widgets/Exam/ExamExitButton/exam_exit_button.dart';
import 'package:plu_trainer/widgets/Training/SelectionBar/playstop_button.dart';
import 'package:plu_trainer/viewmodels/Training/playstop_button_view_model.dart.dart';
import 'package:provider/provider.dart';

class ExamSelectionBar extends StatefulWidget {
  const ExamSelectionBar({super.key});

  @override
  State<ExamSelectionBar> createState() => _ExamSelectionBarState();
}

class _ExamSelectionBarState extends State<ExamSelectionBar> {
  bool _selectionBarIsOpen = true;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _initializeViewModels();
      _isInitialized = true;
    }
  }

  void _initializeViewModels() {
    final timerViewModel = Provider.of<TimerViewModel>(context, listen: false);
    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context, listen: false);
    final examPluListImageViewModel =
        Provider.of<ExamPluListImageViewModel>(context, listen: false);

    timerViewModel.onTimerEnd = () {
      timerViewModel.stopTimer();
      playStopButtonViewModel.stopPlaying();
      setState(() {});
    };

    examPluListImageViewModel.connectToTimer(timerViewModel);

    if (examPluListImageViewModel.showScore) {
      examPluListImageViewModel.checkResultsLength();
      timerViewModel.stopTimer();
      playStopButtonViewModel.stopPlaying();
    }

    timerViewModel.initializeTimer(120);
  }

  void _toggleSelectionBar() {
    setState(() {
      _selectionBarIsOpen = !_selectionBarIsOpen;
    });
  }

  void _handlePlayStop() {
    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context, listen: false);
    final timerViewModel = Provider.of<TimerViewModel>(context, listen: false);

    if (playStopButtonViewModel.isPlaying) {
      playStopButtonViewModel.togglePlayStop();
      timerViewModel.stopTimer();
    } else {
      playStopButtonViewModel.togglePlayStop();
      timerViewModel.startTimer();
    }
  }

  void _handleReset() {
    final examPluListImageViewModel =
        Provider.of<ExamPluListImageViewModel>(context, listen: false);
    final timerViewModel = Provider.of<TimerViewModel>(context, listen: false);
    final examAlertDialogAccessViewModel =
        Provider.of<ExamAlertDialogAccessViewModel>(context, listen: false);

    examPluListImageViewModel.resetButton();
    timerViewModel.resetTimer();
    examAlertDialogAccessViewModel.resetState();
  }

  @override
  Widget build(BuildContext context) {
    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context);
    final timerViewModel = Provider.of<TimerViewModel>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 50,
      width: _selectionBarIsOpen ? 500 : 250,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ContractButton(
              onTap: _toggleSelectionBar,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlayStopButton(
                  isSelectionBarOpen: _selectionBarIsOpen,
                  isPlaying: playStopButtonViewModel.isPlaying,
                  onTap: _handlePlayStop,
                ),
                ExamExitButton(
                  icon: HugeIcons.strokeRoundedUnavailable,
                  isSelectionBarOpen: _selectionBarIsOpen,
                  onTap: _handleReset,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
