import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';

class TrainingProductsText extends StatefulWidget {
  final String text;
  final String plu;
  const TrainingProductsText(
      {super.key, required this.text, required this.plu});

  @override
  State<TrainingProductsText> createState() => _PLUListTextState();
}

class _PLUListTextState extends State<TrainingProductsText> {
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
                  widget.text,
                  style: Fonts.pluListTextStyle,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
              color: CustomColors.grey,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                widget.plu,
                style: Fonts.pluListTextStyle,
              ),
            ),
          ),
        )
      ],
    );
  }
}
