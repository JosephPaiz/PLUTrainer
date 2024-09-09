import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:provider/provider.dart';
import 'package:plu_trainer/viewmodels/History/history_view_model.dart';
import 'package:plu_trainer/widgets/History/history_profile_text.dart';
import 'package:plu_trainer/widgets/History/history_profile_bar.dart';

class HistoryProfileLayout extends StatefulWidget {
  final int superkey;

  const HistoryProfileLayout({super.key, required this.superkey});

  @override
  State<HistoryProfileLayout> createState() => _HistoryProfileLayoutState();
}

class _HistoryProfileLayoutState extends State<HistoryProfileLayout> {
  @override
  void initState() {
    super.initState();
    Provider.of<HistoryViewModel>(context, listen: false)
        .fetchProfileAndHistory(widget.superkey);
  }

  @override
  Widget build(BuildContext context) {
    final historyViewMode = Provider.of<HistoryViewModel>(context);

    return Scaffold(
      body: historyViewMode.isLoading
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
                const HistoryProfileBar(),
                Expanded(
                  child: historyViewMode.historyList.isEmpty
                      ? Center(
                          child: Text(
                            'No hay un historial disponible',
                            style: Fonts.noHistoryExistTextStyle,
                          ),
                        )
                      : ListView.builder(
                          itemCount: historyViewMode.historyList.length,
                          itemBuilder: (context, index) {
                            final history = historyViewMode.historyList[index];
                            return HistoryProfileText(
                              result: history.score.toStringAsFixed(2),
                              answeredAnswers:
                                  history.answeredQuestions.toString(),
                              correctAnswers: history.correctAnswers.toString(),
                              pluHelperUsage: history.pluHelperUsage.toString(),
                              duration: history.duration.toString(),
                              trainingType: history.trainingType.toString(),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
