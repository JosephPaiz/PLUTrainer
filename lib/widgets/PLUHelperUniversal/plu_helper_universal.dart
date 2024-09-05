import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/viewmodels/Training/plu_list_stopwatch_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/stop_watch_view_model.dart';
import 'package:provider/provider.dart';
import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';

class PLUHelperViewUniversal extends StatefulWidget {
  final String pluText;
  final bool isRunning;
  const PLUHelperViewUniversal(
      {super.key, required this.pluText, required this.isRunning});

  @override
  State<PLUHelperViewUniversal> createState() => _PLUHelperViewState();
}

class _PLUHelperViewState extends State<PLUHelperViewUniversal>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final pluHelperViewModel =
        Provider.of<PLUHelperViewModel>(context, listen: false);
    pluHelperViewModel.initAnimationController(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final stopWatchViewModel = Provider.of<StopWatchViewModel>(context);
    final pluListViewStopwatch =
        Provider.of<PLUListStopWatchViewModel>(context);

    final pluHelperviewModel =
        Provider.of<PLUHelperViewModel>(context, listen: false);

    pluHelperviewModel.startAnimationIfNeeded(stopWatchViewModel.isRunning,
        pluListViewStopwatch.results, pluListViewStopwatch.products);
  }

  @override
  Widget build(BuildContext context) {
    final pluHelperViewModel = Provider.of<PLUHelperViewModel>(context);
    final stopWatchViewModel = Provider.of<StopWatchViewModel>(context);
    final pluListStopWatchViewModel =
        Provider.of<PLUListStopWatchViewModel>(context);

    return Container(
      width: 70,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: CustomColors.grey),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: stopWatchViewModel.isRunning
            ? pluHelperViewModel.isAnimationComplete
                ? Center(
                    child: Text(
                      pluListStopWatchViewModel
                          .products[pluHelperViewModel.productIndex].plu
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : AnimatedBuilder(
                    animation: pluHelperViewModel.animationController,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: pluHelperViewModel.animationController.value,
                        backgroundColor: CustomColors.grey,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            CustomColors.deepGrey),
                      );
                    },
                  )
            : Container(
                color: Colors.white,
              ),
      ),
    );
  }
}
