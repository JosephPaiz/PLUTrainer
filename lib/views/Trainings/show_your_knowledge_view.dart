import 'package:flutter/material.dart';
import 'package:plu_trainer/viewmodels/Training/plu_list_stopwatch_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/stop_watch_view_model.dart';
import 'package:plu_trainer/widgets/PLUHelperUniversal/plu_helper_universal.dart';
import 'package:plu_trainer/widgets/PLUListViewStopWatch/plu_list_view_stopwatch.dart';
import 'package:plu_trainer/widgets/SelectionBarNoOptions/selection_bar_no_options.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';
import 'package:plu_trainer/widgets/PLUTextField/plutextfield_bar.dart';
import 'package:provider/provider.dart';

class ShowYourKnowledgeView extends StatefulWidget {
  const ShowYourKnowledgeView({super.key});

  @override
  State<ShowYourKnowledgeView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ShowYourKnowledgeView> {
  @override
  Widget build(BuildContext context) {
    final pluListStopWatchViewModel =
        Provider.of<PLUListStopWatchViewModel>(context);
    final pluHelperViewModel = Provider.of<PLUHelperViewModel>(context);
    final stopWatchViewModel = Provider.of<StopWatchViewModel>(context);
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
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: SelectionBarNoOptions(
                          playVoid: () {
                            stopWatchViewModel.start();
                          },
                          stopVoid: () {
                            stopWatchViewModel.stop();
                          },
                        ),
                      ),
                      const PluListViewStopwatch(),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: PLUTextFiedBar(
                            pluHelper: pluListStopWatchViewModel.products
                                    .isNotEmpty // Asegúrate de que la lista no esté vacía
                                ? PLUHelperViewUniversal(
                                    pluText: pluListStopWatchViewModel.products[
                                            pluHelperViewModel.productIndex]
                                        .toString(),
                                    isRunning: stopWatchViewModel.isRunning,
                                  )
                                : const SizedBox
                                    .shrink(), // Si no hay productos, muestra un widget vacío
                            onPLUEntered: stopWatchViewModel.isRunning
                                ? (pluStr) {
                                    pluListStopWatchViewModel.checkPLU(pluStr);
                                  }
                                : (pluStr) {},
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }
      }),
    );
  }
}
