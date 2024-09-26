import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';

class ExamHistoryProfileText extends StatefulWidget {
  final String result;
  final String answeredAnswers;
  final String correctAnswers;
  final String authorizedSuperkey;
  final String duration;
  const ExamHistoryProfileText({
    super.key,
    required this.result,
    required this.answeredAnswers,
    required this.correctAnswers,
    required this.authorizedSuperkey,
    required this.duration,
  });

  @override
  State<ExamHistoryProfileText> createState() => _HistoryProfileTextState();
}

class _HistoryProfileTextState extends State<ExamHistoryProfileText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: CustomColors.deepGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  widget.result,
                  style: Fonts.historyProfileText,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: CustomColors.deepGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  widget.answeredAnswers,
                  style: Fonts.historyProfileText,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: CustomColors.deepGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  widget.correctAnswers,
                  style: Fonts.historyProfileText,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: CustomColors.deepGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  widget.authorizedSuperkey,
                  style: Fonts.historyProfileText,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: CustomColors.deepGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  widget.duration,
                  style: Fonts.historyProfileText,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
