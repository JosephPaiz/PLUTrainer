import 'package:flutter/material.dart';
import 'package:plu_trainer/viewmodels/Learning/leaning_view_model.dart';
import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/views/leaning_viewd.dart';
import 'package:plu_trainer/widgets/PLUListView/plulist_text.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:plu_trainer/widgets/Score/score_view.dart';
import 'package:plu_trainer/widgets/Timer/timer_view.dart';
import 'package:plu_trainer/widgets/Learning/traning_products_text.dart';
import 'package:provider/provider.dart';

class ProductListMenu extends StatefulWidget {
  const ProductListMenu({super.key});

  @override
  State<ProductListMenu> createState() => _PLUListMenuState();
}

class _PLUListMenuState extends State<ProductListMenu> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LeaningViewModel>(context, listen: false)
          .fetchProductsByLetter('A');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final leaningViewModel = Provider.of<LeaningViewModel>(context);

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
              leaningViewModel.isLoading
                  ? const CircularProgressIndicator()
                  : leaningViewModel.errorMessage != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(leaningViewModel.errorMessage!),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                leaningViewModel.fetchProductsByLetter('A');
                              },
                              child: const Text('Reintentar'),
                            ),
                          ],
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: leaningViewModel.products.length,
                            itemBuilder: (context, index) {
                              return AnimatedOpacity(
                                opacity: leaningViewModel.visibilityFlags[index]
                                    ? 1.0
                                    : 0.0,
                                duration: const Duration(milliseconds: 500),
                                child: TrainingProductsText(
                                  text: leaningViewModel.products[index].name,
                                  plu: leaningViewModel.products[index].plu
                                      .toString(),
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
