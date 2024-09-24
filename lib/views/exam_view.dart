import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/viewmodels/Exam/exam_plu_list_image_view_model.dart';
import 'package:plu_trainer/widgets/Exam/ExamPLUTextField/exam_plu_text_field.dart';
import 'package:plu_trainer/widgets/Exam/ExamPluListImage/exam_plu_list_image_view.dart';
import 'package:plu_trainer/widgets/Exam/ExamSelectionBar/exam_selection_bar.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:provider/provider.dart';

class ExamView extends StatefulWidget {
  const ExamView({super.key});

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  @override
  Widget build(BuildContext context) {
    final examPluListImageViewModel =
        Provider.of<ExamPluListImageViewModel>(context);
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
                        child: ExamSelectionBar(),
                      ),
                      const ExamPluListImageView(
                        trainingType: 'Entrena tu Vista',
                      ),
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: ExamPLUTextFieldBar(
                              onPLUEntered: timerViewModel.isTimerRunning
                                  ? (pluStr) {
                                      examPluListImageViewModel
                                          .checkPLU(pluStr);
                                    }
                                  : (pluStr) {},
                            )),
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
