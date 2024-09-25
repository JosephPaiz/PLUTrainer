import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/viewmodels/Exam/exam_plu_list_image_view_model.dart';
import 'package:plu_trainer/viewmodels/Exam/exam_alert_dialog_access_view_model.dart';
import 'package:plu_trainer/widgets/Exam/ExamAlertDialogAccess/exam_alert_dialog_access.dart';
import 'package:plu_trainer/widgets/Exam/ExamButtonAcces/exam_button_access.dart';
import 'package:plu_trainer/widgets/Exam/ExamPLUTextField/exam_plu_text_field.dart';
import 'package:plu_trainer/widgets/Exam/ExamPluListImage/exam_plu_list_image_view.dart';
import 'package:plu_trainer/widgets/Exam/ExamSelectionBar/exam_selection_bar.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:provider/provider.dart';

class ExamView extends StatefulWidget {
  const ExamView({super.key});

  @override
  _ExamViewState createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final examAlertDialogAccessViewModel =
          Provider.of<ExamAlertDialogAccessViewModel>(context, listen: false);
      examAlertDialogAccessViewModel
          .addListener(_checkPermissionAndDismissDialog);
    });
  }

  @override
  void dispose() {
    final examAlertDialogAccessViewModel =
        Provider.of<ExamAlertDialogAccessViewModel>(context, listen: false);
    examAlertDialogAccessViewModel
        .removeListener(_checkPermissionAndDismissDialog);
    super.dispose();
  }

  void _checkPermissionAndDismissDialog() {
    final examAlertDialogAccessViewModel =
        Provider.of<ExamAlertDialogAccessViewModel>(context, listen: false);
    if (examAlertDialogAccessViewModel.hasPermission && _isDialogShowing) {
      Navigator.of(context).pop();
      _isDialogShowing = false;
    }
  }

  void _showExamAlertDialogAccess() {
    setState(() {
      _isDialogShowing = true;
    });
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.transparent,
          child: const ExamAlertDialogAccess(),
        );
      },
    ).then((_) {
      setState(() {
        _isDialogShowing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.grey,
      body: LayoutBuilder(
        builder: (context, constraints) {
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
                  child: Consumer<ExamAlertDialogAccessViewModel>(
                    builder: (context, examAlertDialogViewModel, _) {
                      if (examAlertDialogViewModel.hasPermission) {
                        return _buildExamContent(context);
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Realiza la prueba de cajeros de PLU',
                                  style: Fonts.examTitleMenu),
                            ),
                            Container(
                              color: CustomColors.grey,
                              child: ExamButtonAccess(
                                onPressed: _showExamAlertDialogAccess,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildExamContent(BuildContext context) {
    final examPluListImageViewModel =
        Provider.of<ExamPluListImageViewModel>(context);
    final timerViewModel = Provider.of<TimerViewModel>(context);

    return Container(
      color: CustomColors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(30),
            child: ExamSelectionBar(),
          ),
          const ExamPluListImageView(
            trainingType: 'Prueba de PLU',
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: ExamPLUTextFieldBar(
                onPLUEntered: timerViewModel.isTimerRunning
                    ? (pluStr) {
                        examPluListImageViewModel.checkPLU(pluStr);
                      }
                    : (pluStr) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
