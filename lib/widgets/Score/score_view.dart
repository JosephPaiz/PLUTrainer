import 'package:flutter/material.dart';
import 'package:plu_trainer/viewmodels/score_view_model.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:provider/provider.dart';

class ScoreView extends StatefulWidget {
  const ScoreView({super.key});

  @override
  State<ScoreView> createState() => _ScoreViewState();
}

class _ScoreViewState extends State<ScoreView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scoreViewModel = Provider.of<ScoreViewModel>(context);
    final productViewModel = Provider.of<ProductViewModel>(context);

    scoreViewModel.updateLists(
        productViewModel.products, productViewModel.results);
  }

  @override
  Widget build(BuildContext context) {
    final scoreViewModel = Provider.of<ScoreViewModel>(context);
    return Expanded(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const Text(
              'Score',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              'Corrects Answers: ${scoreViewModel.correctAnswers}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Result: ${scoreViewModel.result}',
              style: const TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
