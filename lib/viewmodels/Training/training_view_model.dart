import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:plu_trainer/core/localization/plutrainer_localizations_esp.dart';

class TrainingViewModel extends ChangeNotifier {
  final List<String> names = [
    LocalizationsEsp.showYourKnowledge,
    LocalizationsEsp.trainYourMind,
    LocalizationsEsp.trainYourEyesight
  ];

  final List<String> descriptions = [
    LocalizationsEsp.showYourKnowledgeDescription,
    LocalizationsEsp.trainYourMindDescription,
    LocalizationsEsp.trainYourEyesightDescrition
  ];

  final List<IconData> icons = [
    HugeIcons.strokeRoundedOnlineLearning01,
    HugeIcons.strokeRoundedBrain02,
    HugeIcons.strokeRoundedEye
  ];

  final List<String> rutes = [
    '/training/showyourknowledge',
    '/training/trainyourmind',
    '/training/trainyoureyesight',
  ];
}
