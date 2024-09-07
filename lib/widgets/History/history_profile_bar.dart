import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';

class HistoryProfileBar extends StatefulWidget {
  const HistoryProfileBar({super.key});

  @override
  State<HistoryProfileBar> createState() => _HistoryProfileTextState();
}

class _HistoryProfileTextState extends State<HistoryProfileBar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
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
                    'Usos del PLUHelper',
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
                    'Tipo de entrenamiento',
                    style: Fonts.historyProfileText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
