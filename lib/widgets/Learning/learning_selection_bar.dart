import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:plu_trainer/Widgets/SelectionBar/selectionbar_button.dart';
import 'package:plu_trainer/Widgets/contract_button.dart';
import 'package:plu_trainer/viewmodels/Learning/leaning_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/selectionbar_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:plu_trainer/widgets/Learning/learning_selection_bar_button.dart';
import 'package:plu_trainer/widgets/SelectionBar/playstop_button.dart';
import 'package:plu_trainer/viewmodels/Training/playstop_button_view_model.dart.dart';
import 'package:plu_trainer/widgets/SelectionBar/restar_button.dart';
import 'package:provider/provider.dart';

class LearningSelectionBar extends StatefulWidget {
  const LearningSelectionBar({
    super.key,
  });

  @override
  State<LearningSelectionBar> createState() => _SelectionBarMenuState();
}

class _SelectionBarMenuState extends State<LearningSelectionBar> {
  bool selectionBarIsOpen = true;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final leaningViewModel = Provider.of<LeaningViewModel>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 50,
      width: selectionBarIsOpen ? MediaQuery.of(context).size.width : 500,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: leaningViewModel.letters.length,
          itemBuilder: (context, index) {
            final letter = leaningViewModel.letters[index];
            return LearningSelectionBarButton(
              text: letter,

              isSeleccted: false, // Puedes ajustar la lógica de selección
              onTap: () {
                // Lógica para cada letra al hacer clic
                print('Botón de letra seleccionado: $letter');
              },
            );
          },
        ),
      ),
    );
  }
}
