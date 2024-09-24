import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/viewmodels/Exam/exam_plu_list_image_view_model.dart';
import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/plu_list_image_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/viewmodels/score_view_model.dart';
import 'package:plu_trainer/widgets/Training/PLUListImageView/plu_list_image_widget.dart';
import 'package:plu_trainer/widgets/Training/PLUListImageView/plu_list_text_widget.dart';
import 'package:plu_trainer/widgets/Training/Score/score_view.dart';
import 'package:plu_trainer/widgets/Training/Timer/timer_view.dart';
import 'package:provider/provider.dart';

class ExamPluListImageView extends StatefulWidget {
  final String trainingType;
  const ExamPluListImageView({super.key, required this.trainingType});

  @override
  State<ExamPluListImageView> createState() => _PluListImageViewState();
}

class _PluListImageViewState extends State<ExamPluListImageView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel =
          Provider.of<ExamPluListImageViewModel>(context, listen: false);
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
    final examPluListImageViewModel =
        Provider.of<ExamPluListImageViewModel>(context);
    final loginViewModel = Provider.of<LoginViewModel>(context);
    final timerViewModel = Provider.of<TimerViewModel>(context);
    final pluHelperViewModel = Provider.of<PLUHelperViewModel>(context);
    final scoreViewModel = Provider.of<ScoreViewModel>(context);

    final int superkey = loginViewModel.superkeyValue ?? 0;

    if (!examPluListImageViewModel.showScore && scoreViewModel.hasInserted) {
      scoreViewModel.resetData();
    }

    return Expanded(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: CustomColors.white,
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
          child: examPluListImageViewModel.showScore
              ? ScoreView(
                  products: examPluListImageViewModel.products,
                  responses: examPluListImageViewModel.results,
                  superKey: superkey,
                  duration: timerViewModel.elapsedSeconds,
                  trainingType: widget.trainingType,
                  pluHelperUsage: pluHelperViewModel.pluHelperUsage,
                  shouldInsert: !scoreViewModel.hasInserted)
              : Column(
                  children: [
                    const TimerView(),
                    examPluListImageViewModel.isLoading
                        ? const CircularProgressIndicator()
                        : examPluListImageViewModel.errorMessage != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(examPluListImageViewModel.errorMessage!),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      examPluListImageViewModel
                                          .fetchRandomProductsWithImage();
                                    },
                                    child: const Text('Reintentar'),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  if (examPluListImageViewModel
                                      .products.isNotEmpty)
                                    PluListImageWidget(
                                      imageUrl: examPluListImageViewModel
                                              .products[
                                                  examPluListImageViewModel
                                                      .currentIndex]
                                              .imageUrl ??
                                          '',
                                    )
                                  else
                                    const Text(
                                        'No products available'), // Mostrar si no hay productos
                                  if (examPluListImageViewModel
                                      .products.isNotEmpty)
                                    PluListTextWidget(
                                      pluText: examPluListImageViewModel
                                          .products[examPluListImageViewModel
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
