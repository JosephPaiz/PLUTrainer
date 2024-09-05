import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';

class PLUListText extends StatefulWidget {
  final bool showIcon;
  final bool isCorrectAnswer;
  final String text;
  const PLUListText(
      {super.key,
      required this.showIcon,
      required this.isCorrectAnswer,
      required this.text});

  @override
  State<PLUListText> createState() => _PLUListTextState();
}

class _PLUListTextState extends State<PLUListText> {
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
          child: widget.showIcon
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    color: widget.isCorrectAnswer ? Colors.green : Colors.red,
                    widget.isCorrectAnswer
                        ? HugeIcons.strokeRoundedTick04
                        : HugeIcons.strokeRoundedCancel02,
                    key: ValueKey<bool>(widget.isCorrectAnswer),
                    size: 30.0,
                  ),
                )
              : const SizedBox(
                  height: 30,
                  width: 50,
                ),
        )
      ],
    );
  }
}
