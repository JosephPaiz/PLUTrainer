import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';

class PluListTextWidget extends StatefulWidget {
  final String pluText;
  const PluListTextWidget({super.key, required this.pluText});

  @override
  State<PluListTextWidget> createState() => _PluListTextWidgetState();
}

class _PluListTextWidgetState extends State<PluListTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: CustomColors.grey,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.pluText,
              style: Fonts.pluListTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
