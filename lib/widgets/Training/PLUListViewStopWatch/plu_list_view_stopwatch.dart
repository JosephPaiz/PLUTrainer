import 'package:flutter/material.dart';
import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/plu_list_stopwatch_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/stop_watch_view_model.dart';
import 'package:plu_trainer/viewmodels/score_view_model.dart';
import 'package:plu_trainer/widgets/Training/PLUListView/plulist_text.dart';
import 'package:plu_trainer/widgets/Training/Score/score_view.dart';
import 'package:plu_trainer/widgets/Training/Stopwatch/stop_watch.dart';
import 'package:provider/provider.dart';

class PluListViewStopwatch extends StatefulWidget {
  const PluListViewStopwatch({super.key});

  @override
  State<PluListViewStopwatch> createState() => _PluListMenuState();
}

class _PluListMenuState extends State<PluListViewStopwatch> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PLUHelperViewModel>(context, listen: false)
          .resetPluHelperUsage();
      Provider.of<PLUListStopWatchViewModel>(context, listen: false)
          .fetchRandomMoreProducts();
      Provider.of<ScoreViewModel>(context, listen: false).resetData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pluListStopWatchViewModel =
        Provider.of<PLUListStopWatchViewModel>(context);
    final loginViewModel = Provider.of<LoginViewModel>(context);
    final stopWatchViewModel = Provider.of<StopWatchViewModel>(context);
    final pluHelperViewModel = Provider.of<PLUHelperViewModel>(context);
    final scoreViewModel = Provider.of<ScoreViewModel>(context);

    final int superkey = loginViewModel.superkeyValue ?? 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pluListStopWatchViewModel.calculateHeight(context, _key);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pluListStopWatchViewModel.results.isNotEmpty &&
          pluListStopWatchViewModel.results.length % 2 == 0) {
        pluListStopWatchViewModel.scrollToNextItem();
      }
    });

    if (!pluListStopWatchViewModel.showScore && scoreViewModel.hasInserted) {
      scoreViewModel.resetData();
    }

    return Expanded(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 5),
                )
              ]),
          width: 500,
          child: pluListStopWatchViewModel.showScore
              ? ScoreView(
                  products: pluListStopWatchViewModel.products,
                  responses: pluListStopWatchViewModel.results,
                  superKey: superkey,
                  duration: stopWatchViewModel.elapsedSeconds,
                  trainingType: 'Muestra tu Conocimiento',
                  pluHelperUsage: pluHelperViewModel.pluHelperUsage,
                  shouldInsert: !scoreViewModel.hasInserted)
              : Column(
                  children: [
                    const StopWatchView(),
                    pluListStopWatchViewModel.isLoading
                        ? const CircularProgressIndicator()
                        : pluListStopWatchViewModel.errorMessage != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(pluListStopWatchViewModel.errorMessage!),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      pluListStopWatchViewModel
                                          .fetchRandomMoreProducts();
                                    },
                                    child: const Text('Reintentar'),
                                  ),
                                ],
                              )
                            : Expanded(
                                child: ListView.builder(
                                  controller: pluListStopWatchViewModel
                                      .scrollController,
                                  itemCount:
                                      pluListStopWatchViewModel.products.length,
                                  itemBuilder: (context, index) {
                                    bool isVisible = index >=
                                        pluListStopWatchViewModel
                                                .results.length -
                                            1;

                                    return Visibility(
                                      key: index == 0 ? _key : null,
                                      visible: isVisible,
                                      child: AnimatedOpacity(
                                        opacity: 1.0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: PLUListText(
                                          showIcon: index <
                                              pluListStopWatchViewModel
                                                  .results.length,
                                          isCorrectAnswer:
                                              pluListStopWatchViewModel
                                                          .results.length >
                                                      index
                                                  ? pluListStopWatchViewModel
                                                      .results[index]
                                                  : false,
                                          text: pluListStopWatchViewModel
                                              .products[index].name,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                  ],
                ),
        ),
      ),
    );
  }
}
