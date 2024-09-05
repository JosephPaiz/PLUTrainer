import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';

class HistoryProfileText extends StatefulWidget {
  final String result;
  final String answeredAnswers;
  final String correctAnswers;
  final String pluHelperUsage;
  final String duration;
  final String trainingType;
  const HistoryProfileText(
      {super.key,
      required this.result,
      required this.answeredAnswers,
      required this.correctAnswers,
      required this.pluHelperUsage,
      required this.duration,
      required this.trainingType});

  @override
  State<HistoryProfileText> createState() => _HistoryProfileTextState();
}

class _HistoryProfileTextState extends State<HistoryProfileText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Usamos Expanded para que todos los elementos tengan el mismo ancho

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
                  widget.pluHelperUsage,
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
                  widget.trainingType,
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
