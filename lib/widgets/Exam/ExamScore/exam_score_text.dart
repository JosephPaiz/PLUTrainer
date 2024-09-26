import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';

class ExamScoreText extends StatefulWidget {
  final String propety;
  final String value;
  const ExamScoreText({super.key, required this.propety, required this.value});

  @override
  State<ExamScoreText> createState() => _ScoreTextState();
}

class _ScoreTextState extends State<ExamScoreText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: CustomColors.grey,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.propety,
                  style: Fonts.pluListTextStyle,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: CustomColors.grey,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              widget.value,
              style: Fonts.pluListTextStyle,
            ),
          ),
        )
      ],
    );
  }
}
