import 'package:flutter/material.dart';
import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/plu_list_image_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/viewmodels/score_view_model.dart';
import 'package:plu_trainer/widgets/PLUListImageView/plu_list_image_widget.dart';
import 'package:plu_trainer/widgets/PLUListImageView/plu_list_text_widget.dart';
import 'package:plu_trainer/widgets/Score/score_view.dart';
import 'package:plu_trainer/widgets/Timer/timer_view.dart';
import 'package:provider/provider.dart';

class PluListImageView extends StatefulWidget {
  final String trainingType;
  const PluListImageView({super.key, required this.trainingType});

  @override
  State<PluListImageView> createState() => _PluListImageViewState();
}

class _PluListImageViewState extends State<PluListImageView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel =
          Provider.of<PluListImageViewModel>(context, listen: false);
      viewModel.fetchRandomProductsWithImage().then((_) {
        final imageUrls = viewModel.products
            .map((product) => product.imageUrl ?? '')
            .toList();
        // ignore: use_build_context_synchronously
        preCacheImages(context, imageUrls);
      });
    });
  }

  void preCacheImages(BuildContext context, List<String> imageUrls) {
    for (String url in imageUrls) {
      precacheImage(NetworkImage(url), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pluListImageViewModel = Provider.of<PluListImageViewModel>(context);
    final loginViewModel = Provider.of<LoginViewModel>(context);
    final timerViewModel = Provider.of<TimerViewModel>(context);
    final pluHelperViewModel = Provider.of<PLUHelperViewModel>(context);
    final scoreViewModel = Provider.of<ScoreViewModel>(context);

    final int superkey = loginViewModel.superkeyValue ?? 0;

    if (!pluListImageViewModel.showScore && scoreViewModel.hasInserted) {
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
          child: pluListImageViewModel.showScore
              ? ScoreView(
                  products: pluListImageViewModel.products,
                  responses: pluListImageViewModel.results,
                  superKey: superkey,
                  duration: timerViewModel.elapsedSeconds,
                  trainingType: widget.trainingType,
                  pluHelperUsage: pluHelperViewModel.pluHelperUsage,
                  shouldInsert: !scoreViewModel.hasInserted)
              : Column(
                  children: [
                    const TimerView(),
                    pluListImageViewModel.isLoading
                        ? const CircularProgressIndicator()
                        : pluListImageViewModel.errorMessage != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(pluListImageViewModel.errorMessage!),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      pluListImageViewModel
                                          .fetchRandomProductsWithImage();
                                    },
                                    child: const Text('Reintentar'),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  if (pluListImageViewModel.products.isNotEmpty)
                                    PluListImageWidget(
                                      imageUrl: pluListImageViewModel
                                              .products[pluListImageViewModel
                                                  .currentIndex]
                                              .imageUrl ??
                                          '',
                                    )
                                  else
                                    const Text(
                                        'No products available'), // Mostrar si no hay productos
                                  if (pluListImageViewModel.products.isNotEmpty)
                                    PluListTextWidget(
                                      pluText: pluListImageViewModel
                                          .products[pluListImageViewModel
                                              .currentIndex]
                                          .name,
                                    )
                                  else
                                    Container(), //
                                ],
                              )
                  ],
                ),
        ),
      ),
    );
  }
}
