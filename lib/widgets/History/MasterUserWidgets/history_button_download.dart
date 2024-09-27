import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';

class HistoryButtonDownload extends StatelessWidget {
  final VoidCallback downloadHistory;
  const HistoryButtonDownload({super.key, required this.downloadHistory});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.darkGreen,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: downloadHistory,
      child: const Text(
        'Descarga el Historial',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
