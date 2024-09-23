import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/widgets/Training/PLUHelper/pluhelper_view.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';
import 'package:plu_trainer/widgets/Training/PLUListView/plulist_menu.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/widgets/Training/PLUTextField/plutextfield_bar.dart';
import 'package:plu_trainer/widgets/Training/SelectionBar/selectionbar_menu.dart';
import 'package:provider/provider.dart';

class TrainYourMindView extends StatefulWidget {
  const TrainYourMindView({super.key});

  @override
  State<TrainYourMindView> createState() => _ExamViewState();
}

class _ExamViewState extends State<TrainYourMindView> {
  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final timerViewModel = Provider.of<TimerViewModel>(context);
    return Scaffold(
      backgroundColor: CustomColors.grey,
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
                  color: CustomColors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(30),
                        child: SelectionBarMenu(
                          firstTime: 60,
                          secondTime: 90,
                          thirdTime: 120,
                          firstText: '1',
                          secondText: '1.5',
                          thirdText: '2',
                        ),
                      ),
                      const PLUListMenu(
                        trainingType: 'Entrena tu mente',
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: PLUTextFiedBar(
                            pluHelper: productViewModel.isLoading ||
                                    productViewModel.products.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : PLUHelperView(
                                    pluText: productViewModel
                                        .products[productViewModel.currentIndex]
                                        .plu
                                        .toString(),
                                    isTimerRunning:
                                        timerViewModel.isTimerRunning,
                                    results: productViewModel.results,
                                    products: productViewModel.products,
                                  ),
                            onPLUEntered: timerViewModel.isTimerRunning
                                ? (pluStr) {
                                    productViewModel.checkPLU(pluStr);
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
