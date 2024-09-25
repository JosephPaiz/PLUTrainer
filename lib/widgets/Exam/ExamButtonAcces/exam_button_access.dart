import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';

class ExamButtonAccess extends StatelessWidget {
  final VoidCallback onPressed;

  const ExamButtonAccess({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(100, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: CustomColors.darkGreen),
        child: Text(
          'Acceder a la prueba',
          style: Fonts.examButtonText,
        ),
      ),
    );
  }
}
