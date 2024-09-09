import 'package:flutter/material.dart';
import 'package:plu_trainer/widgets/History/MasterUserWidgets/history_master_profile_layout.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20), // Definir padding
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(20), // Aplicamos el BorderRadius aquí
        child: Container(
          // No necesitas Expanded aquí
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white, // Definir el color de fondo
          child:
              const HistoryMasterProfileLayout(), // El contenido que se mostrará
        ),
      ),
    );
  }
}
