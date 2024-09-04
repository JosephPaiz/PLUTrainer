import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:plu_trainer/Widgets/SelectionBar/selectionbar_button.dart';
import 'package:plu_trainer/Widgets/contract_button.dart';
import 'package:plu_trainer/viewmodels/Training/selectionbar_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:plu_trainer/widgets/SelectionBar/playstop_button.dart';
import 'package:plu_trainer/viewmodels/Training/playstop_button_view_model.dart.dart';
import 'package:provider/provider.dart';

class SelectionBarMenu extends StatefulWidget {
  final int firstTime;
  final int secondTime;
  final int thirdTime;
  final String firstText;
  final String secondText;
  final String thirdText;

  const SelectionBarMenu(
      {super.key,
      required this.firstTime,
      required this.secondTime,
      required this.thirdTime,
      required this.firstText,
      required this.secondText,
      required this.thirdText});

  @override
  State<SelectionBarMenu> createState() => _SelectionBarMenuState();
}

class _SelectionBarMenuState extends State<SelectionBarMenu> {
  bool selectionBarIsOpen = true;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final timerViewModel = Provider.of<TimerViewModel>(context, listen: false);
    final productViewModel = Provider.of<ProductViewModel>(context);
    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context);

    timerViewModel.onTimerEnd = () {
      productViewModel.fetchRandomProducts();
      playStopButtonViewModel.stopPlaying();
    };

    if (!_isInitialized) {
      timerViewModel.initializeTimer(widget.firstTime);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectionBarViewModel = Provider.of<SelectionBarViewModel>(context);
    final productsViewModel = Provider.of<ProductViewModel>(context);
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
                SelectionbarButton(
                  icon: HugeIcons.strokeRoundedTimeQuarterPass,
                  text: '${widget.firstText}min',
                  isSelectionBarOpen: selectionBarIsOpen,
                  isSeleccted: selectionBarViewModel.selectedIndex == 0,
                  onTap: timerViewModel.isTimerRunning
                      ? () {}
                      : () {
                          productsViewModel.fetchRandomProducts();
                          selectionBarViewModel.selectIndex(0);
                          timerViewModel.setTimerDuration(widget.firstTime);
                        },
                ),
                SelectionbarButton(
                  icon: HugeIcons.strokeRoundedTimeHalfPass,
                  text: '${widget.secondText}min',
                  isSelectionBarOpen: selectionBarIsOpen,
                  isSeleccted: selectionBarViewModel.selectedIndex == 1,
                  onTap: timerViewModel.isTimerRunning
                      ? () {}
                      : () {
                          productsViewModel.fetchRandomProducts();
                          selectionBarViewModel.selectIndex(1);
                          timerViewModel.setTimerDuration(widget.secondTime);
                        },
                ),
                SelectionbarButton(
                  icon: HugeIcons.strokeRoundedTimeQuarter,
                  text: '${widget.thirdText}min',
                  isSelectionBarOpen: selectionBarIsOpen,
                  isSeleccted: selectionBarViewModel.selectedIndex == 2,
                  onTap: timerViewModel.isTimerRunning
                      ? () {}
                      : () {
                          productsViewModel.fetchRandomProducts();
                          selectionBarViewModel.selectIndex(2);
                          timerViewModel.setTimerDuration(widget.thirdTime);
                        },
                ),
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
