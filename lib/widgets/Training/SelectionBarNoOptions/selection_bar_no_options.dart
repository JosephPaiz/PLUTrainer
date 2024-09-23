import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:plu_trainer/Widgets/contract_button.dart';
import 'package:plu_trainer/viewmodels/Training/plu_list_stopwatch_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/stop_watch_view_model.dart';
import 'package:plu_trainer/widgets/Training/SelectionBar/playstop_button.dart';
import 'package:plu_trainer/viewmodels/Training/playstop_button_view_model.dart.dart';
import 'package:plu_trainer/widgets/Training/SelectionBar/restar_button.dart';
import 'package:provider/provider.dart';

class SelectionBarNoOptions extends StatefulWidget {
  final VoidCallback playVoid;
  final VoidCallback stopVoid;
  const SelectionBarNoOptions(
      {super.key, required this.playVoid, required this.stopVoid});

  @override
  State<SelectionBarNoOptions> createState() => _ExamSelectionBarState();
}

class _ExamSelectionBarState extends State<SelectionBarNoOptions> {
  bool selectionBarIsOpen = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final stopWatchViewModel = Provider.of<StopWatchViewModel>(context);
    final plulistViewStopWatchViewModel =
        Provider.of<PLUListStopWatchViewModel>(context).results;
    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context);
    stopWatchViewModel.setResultList(plulistViewStopWatchViewModel, () {
      playStopButtonViewModel.stopPlaying();
    });
  }

  @override
  Widget build(BuildContext context) {
    final playStopButtonViewModel =
        Provider.of<PlayStopButtonViewModel>(context);
    final plulistViewStopWatchViewModel =
        Provider.of<PLUListStopWatchViewModel>(context);
    final stopWatchViewModel = Provider.of<StopWatchViewModel>(context);

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
                          widget.stopVoid();
                        }
                      : () {
                          playStopButtonViewModel.togglePlayStop();
                          widget.playVoid();
                        },
                ),
                RestarButton(
                    icon: HugeIcons.strokeRoundedReload,
                    isSelectionBarOpen: selectionBarIsOpen,
                    onTap: () {
                      plulistViewStopWatchViewModel.resetButton();
                      stopWatchViewModel.reset();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
