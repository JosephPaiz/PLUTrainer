import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:plu_trainer/Widgets/contract_button.dart';
import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/selectionbar_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:plu_trainer/widgets/Training/SelectionBar/playstop_button.dart';
import 'package:plu_trainer/viewmodels/Training/playstop_button_view_model.dart.dart';
import 'package:plu_trainer/widgets/Training/SelectionBar/restar_button.dart';
import 'package:plu_trainer/widgets/Training/SelectionBar/selectionbar_button.dart';
import 'package:provider/provider.dart';

class SelectionBarMenu extends StatefulWidget {
  final int firstTime;
  final int secondTime;
  final int thirdTime;
  final String firstText;
  final String secondText;
  final String thirdText;

  const SelectionBarMenu({
    super.key,
    required this.firstTime,
    required this.secondTime,
    required this.thirdTime,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
  });

  @override
  State<SelectionBarMenu> createState() => _SelectionBarMenuState();
}

class _SelectionBarMenuState extends State<SelectionBarMenu> {
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
    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context, listen: false);

    timerViewModel.onTimerEnd = () {
      timerViewModel.stopTimer();
      playStopButtonViewModel.stopPlaying();
      setState(() {});
    };

    productViewModel.connectToTimer(timerViewModel);

    if (productViewModel.showScore) {
      productViewModel.checkResultsLength();
      timerViewModel.stopTimer();
      playStopButtonViewModel.stopPlaying();
    }

    timerViewModel.initializeTimer(widget.firstTime);
  }

  void _toggleSelectionBar() {
    setState(() {
      _selectionBarIsOpen = !_selectionBarIsOpen;
    });
  }

  void _handleTimeSelection(int index, int time) {
    final timerViewModel = Provider.of<TimerViewModel>(context, listen: false);
    final selectionBarViewModel =
        Provider.of<SelectionBarViewModel>(context, listen: false);
    final productsViewModel =
        Provider.of<ProductViewModel>(context, listen: false);

    if (!timerViewModel.isTimerRunning) {
      productsViewModel.fetchRandomProducts();
      selectionBarViewModel.selectIndex(index);
      timerViewModel.setTimerDuration(time);
    }
  }

  void _handlePlayStop() {
    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context, listen: false);
    final timerViewModel = Provider.of<TimerViewModel>(context, listen: false);
    final productsViewModel =
        Provider.of<ProductViewModel>(context, listen: false);

    if (!productsViewModel.showScore) {
      if (playStopButtonViewModel.isPlaying) {
        playStopButtonViewModel.togglePlayStop();
        timerViewModel.stopTimer();
      } else {
        playStopButtonViewModel.togglePlayStop();
        timerViewModel.startTimer();
      }
    }
  }

  void _handleReset() {
    final productsViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    final timerViewModel = Provider.of<TimerViewModel>(context, listen: false);
    final pluHelperViewModel =
        Provider.of<PLUHelperViewModel>(context, listen: false);
    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context, listen: false);

    productsViewModel.resetButton();
    timerViewModel.resetTimer();
    pluHelperViewModel.resetPluHelperUsage();
    playStopButtonViewModel.stopPlaying();
  }

  @override
  Widget build(BuildContext context) {
    final selectionBarViewModel = Provider.of<SelectionBarViewModel>(context);
    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context);
    final timerViewModel = Provider.of<TimerViewModel>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 50,
      width: _selectionBarIsOpen ? MediaQuery.of(context).size.width : 500,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ContractButton(onTap: _toggleSelectionBar),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectionbarButton(
                  icon: HugeIcons.strokeRoundedTimeQuarterPass,
                  text: '${widget.firstText}min',
                  isSelectionBarOpen: _selectionBarIsOpen,
                  isSeleccted: selectionBarViewModel.selectedIndex == 0,
                  onTap: () => _handleTimeSelection(0, widget.firstTime),
                ),
                SelectionbarButton(
                  icon: HugeIcons.strokeRoundedTimeHalfPass,
                  text: '${widget.secondText}min',
                  isSelectionBarOpen: _selectionBarIsOpen,
                  isSeleccted: selectionBarViewModel.selectedIndex == 1,
                  onTap: () => _handleTimeSelection(1, widget.secondTime),
                ),
                SelectionbarButton(
                  icon: HugeIcons.strokeRoundedTimeQuarter,
                  text: '${widget.thirdText}min',
                  isSelectionBarOpen: _selectionBarIsOpen,
                  isSeleccted: selectionBarViewModel.selectedIndex == 2,
                  onTap: () => _handleTimeSelection(2, widget.thirdTime),
                ),
                PlayStopButton(
                  isSelectionBarOpen: _selectionBarIsOpen,
                  isPlaying: playStopButtonViewModel.isPlaying &&
                      timerViewModel.timeLeft > 0,
                  onTap: _handlePlayStop,
                ),
                RestarButton(
                  icon: HugeIcons.strokeRoundedReload,
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
