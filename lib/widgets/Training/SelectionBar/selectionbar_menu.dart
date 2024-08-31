import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:plu_trainer/Widgets/Training/SelectionBar/selectionbar_button.dart';
import 'package:plu_trainer/Widgets/contract_button.dart';
import 'package:plu_trainer/viewmodels/Training/selectionbar_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:plu_trainer/widgets/Training/SelectionBar/playstop_button.dart';
import 'package:plu_trainer/viewmodels/Training/playstop_button_view_model.dart.dart';
import 'package:provider/provider.dart';

class SelectionBarMenu extends StatefulWidget {
  const SelectionBarMenu({super.key});

  @override
  State<SelectionBarMenu> createState() => _SelectionBarMenuState();
}

class _SelectionBarMenuState extends State<SelectionBarMenu> {
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
                  text: '2min',
                  isSelectionBarOpen: selectionBarIsOpen,
                  isSeleccted: selectionBarViewModel.selectedIndex == 0,
                  onTap: timerViewModel.isTimerRunning
                      ? () {}
                      : () {
                          productsViewModel.fetchRandomProducts();
                          selectionBarViewModel.selectIndex(0);
                          timerViewModel.setTimerDuration(120);
                        },
                ),
                SelectionbarButton(
                  icon: HugeIcons.strokeRoundedTimeHalfPass,
                  text: '5min',
                  isSelectionBarOpen: selectionBarIsOpen,
                  isSeleccted: selectionBarViewModel.selectedIndex == 1,
                  onTap: timerViewModel.isTimerRunning
                      ? () {}
                      : () {
                          productsViewModel.fetchRandomProducts();
                          selectionBarViewModel.selectIndex(1);
                          timerViewModel.setTimerDuration(300);
                        },
                ),
                SelectionbarButton(
                  icon: HugeIcons.strokeRoundedTimeQuarter,
                  text: '10min',
                  isSelectionBarOpen: selectionBarIsOpen,
                  isSeleccted: selectionBarViewModel.selectedIndex == 2,
                  onTap: timerViewModel.isTimerRunning
                      ? () {}
                      : () {
                          productsViewModel.fetchRandomProducts();
                          selectionBarViewModel.selectIndex(2);
                          timerViewModel.setTimerDuration(600);
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
