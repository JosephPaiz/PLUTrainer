import 'package:flutter/material.dart';
import 'package:plu_trainer/viewmodels/Training/plu_list_stopwatch_view_model.dart';
import 'package:plu_trainer/widgets/PLUListView/plulist_text.dart';
import 'package:plu_trainer/widgets/Stopwatch/stop_watch.dart';
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
      Provider.of<PLUListStopWatchViewModel>(context, listen: false)
          .fetchRandomMoreProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pluListStopWatchViewModel =
        Provider.of<PLUListStopWatchViewModel>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pluListStopWatchViewModel.calculateHeight(context, _key);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pluListStopWatchViewModel.results.isNotEmpty &&
          pluListStopWatchViewModel.results.length % 2 == 0) {
        pluListStopWatchViewModel.scrollToNextItem();
      }
    });

    return Expanded(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: 500,
          child: Column(
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
                            controller:
                                pluListStopWatchViewModel.scrollController,
                            itemCount:
                                pluListStopWatchViewModel.products.length,
                            itemBuilder: (context, index) {
                              bool isVisible = index >=
                                  pluListStopWatchViewModel.results.length - 1;

                              return Visibility(
                                key: index == 0 ? _key : null,
                                visible: isVisible,
                                child: AnimatedOpacity(
                                  opacity: 1.0,
                                  duration: const Duration(milliseconds: 500),
                                  child: PLUListText(
                                    showIcon: index <
                                        pluListStopWatchViewModel
                                            .results.length,
                                    isCorrectAnswer: pluListStopWatchViewModel
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
