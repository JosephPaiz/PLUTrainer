import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/viewmodels/History/exam_history_view_model.dart';
import 'package:plu_trainer/viewmodels/History/history_button_select_mode_view_model.dart';
import 'package:plu_trainer/viewmodels/History/history_view_model.dart';
import 'package:plu_trainer/widgets/History/Exam/exam_history_profile_layout.dart';
import 'package:plu_trainer/widgets/History/Training/history_profile_bar.dart';
import 'package:plu_trainer/widgets/History/Training/history_profile_layout.dart';
import 'package:plu_trainer/widgets/History/Training/history_profile_text.dart';
import 'package:plu_trainer/widgets/History/history_button_select_mode.dart';
import 'package:provider/provider.dart';

class HistoryCombinationView extends StatefulWidget {
  final int superkey;

  const HistoryCombinationView({super.key, required this.superkey});

  @override
  State<HistoryCombinationView> createState() => _HistoryCombinationViewState();
}

class _HistoryCombinationViewState extends State<HistoryCombinationView> {
  @override
  void initState() {
    super.initState();
    Provider.of<HistoryViewModel>(context, listen: false)
        .fetchProfileAndHistory(widget.superkey);
    Provider.of<ExamHistoryViewModel>(context, listen: false)
        .fetchExamHistory(widget.superkey);
  }

  @override
  Widget build(BuildContext context) {
    final historyViewMode = Provider.of<HistoryViewModel>(context);
    final historyButtonSelectModeViewModel =
        Provider.of<HistoryButtonSelectModeViewModel>(context);
    return historyViewMode.isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    historyViewMode.profileName ?? 'Unknown',
                    style: Fonts.historyViewTitleTextStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HistoryButtonSelectMode(
                          text: 'Entrenamiento',
                          isSelected:
                              historyButtonSelectModeViewModel.selectedIndex ==
                                  0,
                          onTap: () {
                            historyButtonSelectModeViewModel.selectIndex(0);
                          }),
                      HistoryButtonSelectMode(
                          text: 'Pruebas',
                          isSelected:
                              historyButtonSelectModeViewModel.selectedIndex ==
                                  1,
                          onTap: () {
                            historyButtonSelectModeViewModel.selectIndex(1);
                          })
                    ],
                  ),
                ),
              ),
              historyButtonSelectModeViewModel.selectedIndex == 0
                  ? Expanded(
                      child: HistoryProfileLayout(superkey: widget.superkey),
                    )
                  : Expanded(
                      child:
                          ExamHistoryProfileLayout(superkey: widget.superkey))
            ],
          );
  }
}
