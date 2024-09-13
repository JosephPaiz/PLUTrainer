import 'package:flutter/material.dart';
import 'package:plu_trainer/core/localization/plutrainer_localizations_esp.dart';
import 'package:plu_trainer/viewmodels/Home/information_card_view_model.dart';
import 'package:plu_trainer/widgets/Home/information_card_widget.dart';
import 'package:provider/provider.dart';

class InformationCardMenu extends StatefulWidget {
  final int superkey;
  const InformationCardMenu({super.key, required this.superkey});

  @override
  State<InformationCardMenu> createState() => _InformationCardMenuState();
}

class _InformationCardMenuState extends State<InformationCardMenu> {
  @override
  void initState() {
    final informationCardViewModel =
        Provider.of<InformationCardViewModel>(context, listen: false);

    informationCardViewModel.fetchHistory(widget.superkey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final informationCardViewModel =
        Provider.of<InformationCardViewModel>(context, listen: true);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InformationCardWidget(
              title: 'Respuestas Correctas',
              description: LocalizationsEsp.correctAnswerCardDescription,
              number: '${informationCardViewModel.realCorrectAnswers}/10',
              backGroundColor: const Color(0xFF675DF5),
              icon: Icons.check_circle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InformationCardWidget(
              title: 'Puntaje por prueba',
              description: LocalizationsEsp.averagePerTestcardDescription,
              number:
                  informationCardViewModel.averagePerTest.toStringAsFixed(1),
              backGroundColor: Colors.green,
              icon: Icons.remove_circle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InformationCardWidget(
              title: 'Usos del ayudando PLU',
              description: LocalizationsEsp.pluHelperUsageCardDescription,
              number: informationCardViewModel.averagePerPlUHelper
                  .toStringAsFixed(1),
              backGroundColor: Colors.orange,
              icon: Icons.flag_circle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InformationCardWidget(
              title: 'Tiempo por Pregunta',
              description: LocalizationsEsp.timePerQuestionCardDescription,
              number:
                  '${informationCardViewModel.timePerQuestion.toStringAsFixed(1)}S',
              backGroundColor: Colors.red,
              icon: Icons.incomplete_circle,
            ),
          ),
        ],
      ),
    );
  }
}
