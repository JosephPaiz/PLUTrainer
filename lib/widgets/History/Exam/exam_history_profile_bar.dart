import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';

class ExamHistoryProfileBar extends StatefulWidget {
  const ExamHistoryProfileBar({super.key});

  @override
  State<ExamHistoryProfileBar> createState() => _HistoryProfileBarState();
}

class _HistoryProfileBarState extends State<ExamHistoryProfileBar> {
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
                  'Resultado',
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
                  'Respuestas contestadas',
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
                  'Respuestas correctas',
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
                  'Autorizado por:',
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
                  'Duración',
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
