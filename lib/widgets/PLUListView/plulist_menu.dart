import 'package:flutter/material.dart';
import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/widgets/PLUListView/plulist_text.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:plu_trainer/widgets/Score/score_view.dart';
import 'package:plu_trainer/widgets/Timer/timer_view.dart';
import 'package:provider/provider.dart';

class PLUListMenu extends StatefulWidget {
  final String trainingType;
  const PLUListMenu({super.key, required this.trainingType});

  @override
  State<PLUListMenu> createState() => _PLUListMenuState();
}

class _PLUListMenuState extends State<PLUListMenu> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductViewModel>(context, listen: false)
          .fetchRandomProducts();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsViewModel = Provider.of<ProductViewModel>(context);
    final loginViewModel = Provider.of<LoginViewModel>(context);
    final timerViewModel = Provider.of<TimerViewModel>(context);
    final pluHelperViewModel = Provider.of<PLUHelperViewModel>(context);

    final int superkey = loginViewModel.superkeyValue ?? 0;

    return Expanded(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: 500,
          child: productsViewModel.showScore
              ? ScoreView(
                  products: productsViewModel.products,
                  responses: productsViewModel.results,
                  superKey: superkey,
                  duration: timerViewModel.elapsedSeconds,
                  trainingType: widget.trainingType,
                  pluHelperUsage: pluHelperViewModel.pluHelperUsage,
                  shouldInsert: productsViewModel.showScore)
              : Column(
                  children: [
                    const TimerView(),
                    productsViewModel.isLoading
                        ? const CircularProgressIndicator()
                        : productsViewModel.errorMessage != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(productsViewModel.errorMessage!),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      productsViewModel.fetchRandomProducts();
                                    },
                                    child: const Text('Reintentar'),
                                  ),
                                ],
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: productsViewModel.products.length,
                                  itemBuilder: (context, index) {
                                    return AnimatedOpacity(
                                      opacity: productsViewModel
                                              .visibilityFlags[index]
                                          ? 1.0
                                          : 0.0,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: PLUListText(
                                        showIcon: index <
                                            productsViewModel.results.length,
                                        isCorrectAnswer: productsViewModel
                                                    .results.length >
                                                index
                                            ? productsViewModel.results[index]
                                            : false,
                                        text: productsViewModel
                                            .products[index].name,
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
