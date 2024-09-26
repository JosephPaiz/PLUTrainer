import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/viewmodels/History/exam_history_view_model.dart';
import 'package:plu_trainer/widgets/History/Exam/exam_history_profile_bar.dart';
import 'package:plu_trainer/widgets/History/Exam/exam_history_profile_text.dart';
import 'package:provider/provider.dart';

class ExamHistoryProfileLayout extends StatefulWidget {
  final int superkey;

  const ExamHistoryProfileLayout({super.key, required this.superkey});

  @override
  State<ExamHistoryProfileLayout> createState() => _HistoryProfileLayoutState();
}

class _HistoryProfileLayoutState extends State<ExamHistoryProfileLayout> {
  @override
  Widget build(BuildContext context) {
    final examHistoryViewMode = Provider.of<ExamHistoryViewModel>(context);

    return examHistoryViewMode.isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              const ExamHistoryProfileBar(),
              Expanded(
                child: examHistoryViewMode.historyList.isEmpty
                    ? Center(
                        child: Text(
                          'No hay un historial disponible',
                          style: Fonts.noHistoryExistTextStyle,
                        ),
                      )
                    : ListView.builder(
                        itemCount: examHistoryViewMode.historyList.length,
                        itemBuilder: (context, index) {
                          final history =
                              examHistoryViewMode.historyList[index];
                          return ExamHistoryProfileText(
                            result: history.score.toStringAsFixed(2),
                            answeredAnswers:
                                history.answeredQuestions.toString(),
                            correctAnswers: history.correctAnswers.toString(),
                            authorizedSuperkey:
                                history.authorizedSuperkey.toString(),
                            duration: history.duration.toString(),
                          );
                        },
                      ),
              ),
            ],
          );
  }
}
