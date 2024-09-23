import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/viewmodels/Training/plu_list_image_view_model.dart';
import 'package:plu_trainer/widgets/Training/PLUHelper/pluhelper_view.dart';
import 'package:plu_trainer/widgets/Training/PLUListImageView/plu_list_image_view.dart';
import 'package:plu_trainer/widgets/Training/SelectionBarImage/selection_bar_image_menu.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/widgets/Training/PLUTextField/plutextfield_bar.dart';
import 'package:provider/provider.dart';

class TrainYourEyesightView extends StatefulWidget {
  const TrainYourEyesightView({super.key});

  @override
  State<TrainYourEyesightView> createState() => _ExamViewState();
}

class _ExamViewState extends State<TrainYourEyesightView> {
  @override
  Widget build(BuildContext context) {
    final pluListImageViewModel = Provider.of<PluListImageViewModel>(context);
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
                        child: SelectionBarImageMenu(
                          firstTime: 60,
                          secondTime: 90,
                          thirdTime: 120,
                          firstText: '1',
                          secondText: '1.5',
                          thirdText: '2',
                        ),
                      ),
                      const PluListImageView(
                        trainingType: 'Entrena tu Vista',
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: PLUTextFiedBar(
                            pluHelper: pluListImageViewModel.isLoading ||
                                    pluListImageViewModel.products.isEmpty ||
                                    pluListImageViewModel.currentIndex >=
                                        pluListImageViewModel.products.length
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : PLUHelperView(
                                    pluText: pluListImageViewModel
                                        .products[
                                            pluListImageViewModel.currentIndex]
                                        .plu
                                        .toString(),
                                    isTimerRunning:
                                        timerViewModel.isTimerRunning,
                                    results: pluListImageViewModel.results,
                                    products: pluListImageViewModel.products),
                            onPLUEntered: timerViewModel.isTimerRunning
                                ? (pluStr) {
                                    pluListImageViewModel.checkPLU(pluStr);
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
