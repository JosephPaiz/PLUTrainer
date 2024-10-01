import 'package:flutter/material.dart';
import 'package:plu_trainer/core/localization/plutrainer_localizations_esp.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/viewmodels/Exam/exam_score_view_model.dart';
import 'package:plu_trainer/widgets/Exam/ExamScore/exam_score_text.dart';
import 'package:provider/provider.dart';

class ExamScoreView extends StatefulWidget {
  final List<dynamic> products;
  final List<bool> responses;
  final int superKey;
  final int duration;
  final int authorizedSuperkey;
  final bool shouldInsert;
  const ExamScoreView(
      {super.key,
      required this.products,
      required this.responses,
      required this.superKey,
      required this.authorizedSuperkey,
      required this.duration,
      required this.shouldInsert});

  @override
  State<ExamScoreView> createState() => _ScoreViewState();
}

class _ScoreViewState extends State<ExamScoreView> {
  @override
  void initState() {
    super.initState();
    _insertHistory();
  }

  void _insertHistory() {
    final examScoreViewModel =
        Provider.of<ExamScoreViewModel>(context, listen: false);

    if (widget.shouldInsert) {
      examScoreViewModel.updateData(
        products: widget.products,
        responses: widget.responses,
        superKey: widget.superKey,
        duration: widget.duration,
        authorizedSuperkey: widget.authorizedSuperkey,
        // shouldInsert: widget.shouldInsert,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final examScoreViewModel = Provider.of<ExamScoreViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          LocalizationsEsp.scoreTitle,
          style: Fonts.scoreViewTitleTexStyle,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Autorizado por: ${examScoreViewModel.profileName}',
            style: Fonts.scoreNameViewTitleTexStyle,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ExamScoreText(
            propety: LocalizationsEsp.answeredAnswers,
            value: examScoreViewModel.answeredAnswers.toString()),
        ExamScoreText(
            propety: LocalizationsEsp.correctAnswersText,
            value: examScoreViewModel.correctAnswers.toString()),
        ExamScoreText(
            propety: LocalizationsEsp.duration,
            value: '${examScoreViewModel.duration.toString()}s'),
        ExamScoreText(
            propety: LocalizationsEsp.result,
            value: examScoreViewModel.score.toStringAsFixed(2)),
      ],
    );
  }
}
