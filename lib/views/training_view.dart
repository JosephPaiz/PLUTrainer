import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';
import 'package:plu_trainer/widgets/Training/training_option_button.dart';
import 'package:plu_trainer/viewmodels/Training/training_view_model.dart';
import 'package:provider/provider.dart';

class TrainingView extends StatefulWidget {
  const TrainingView({super.key});

  @override
  State<TrainingView> createState() => _TrainingViewState();
}

class _TrainingViewState extends State<TrainingView> {
  @override
  Widget build(BuildContext context) {
    final trainingViewModel =
        Provider.of<TrainingViewModel>(context); // Obtener el ViewModel

    return Scaffold(
      backgroundColor: CustomColors.grey,
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const Center(
            child: Text(
              'Not yet available for mobile',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          return Row(
            children: [
              const SidebarMenu(),
              Expanded(
                flex: 4,
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: List.generate(3, (index) {
                    return TrainingOptionButton(
                      trainingIcon: trainingViewModel.icons[index],
                      nameOfTheTraining: trainingViewModel.names[index],
                      descriptionOfTheTraining:
                          trainingViewModel.descriptions[index],
                      rute: trainingViewModel.rutes[index],
                    );
                  }),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
