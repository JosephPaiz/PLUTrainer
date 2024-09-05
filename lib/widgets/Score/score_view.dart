import 'package:flutter/material.dart';
import 'package:plu_trainer/core/localization/plutrainer_localizations_esp.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/viewmodels/score_view_model.dart';
import 'package:plu_trainer/widgets/Score/score_text.dart';
import 'package:provider/provider.dart';

class ScoreView extends StatefulWidget {
  final List<dynamic> products;
  final List<bool> responses;
  final int superKey;
  final int duration;
  final String trainingType;
  final int pluHelperUsage;
  final bool shouldInsert;
  const ScoreView(
      {super.key,
      required this.products,
      required this.responses,
      required this.superKey,
      required this.duration,
      required this.trainingType,
      required this.pluHelperUsage,
      required this.shouldInsert});

  @override
  State<ScoreView> createState() => _ScoreViewState();
}

class _ScoreViewState extends State<ScoreView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final scoreViewModel = Provider.of<ScoreViewModel>(context, listen: false);

    scoreViewModel.updateData(
      products: widget.products,
      responses: widget.responses,
      superKey: widget.superKey,
      duration: widget.duration,
      trainingType: widget.trainingType,
      pluHelperUsage: widget.pluHelperUsage,
      shouldInsert: widget.shouldInsert,
    );
    // });
  }

  @override
  Widget build(BuildContext context) {
    final scoreViewModel = Provider.of<ScoreViewModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          LocalizationsEsp.scoreTitle,
          style: Fonts.scoreViewTitleTexStyle,
        ),
        const SizedBox(
          height: 30,
        ),
        ScoreText(
            propety: LocalizationsEsp.answeredAnswers,
            value: scoreViewModel.answeredAnswers.toString()),
        ScoreText(
            propety: LocalizationsEsp.correctAnswersText,
            value: scoreViewModel.correctAnswers.toString()),
        ScoreText(
            propety: LocalizationsEsp.pluHelperUsage,
            value: scoreViewModel.pluHelperUsage.toString()),
        ScoreText(
            propety: LocalizationsEsp.duration,
            value: scoreViewModel.duration.toString()),
        ScoreText(
            propety: LocalizationsEsp.result,
            value: scoreViewModel.score.toString()),
      ],
    );
  }
}
