import 'package:flutter/material.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:provider/provider.dart';

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  @override
  Widget build(BuildContext context) {
    final timerViewModel = Provider.of<TimerViewModel>(context);
    return Text(
      '${timerViewModel.timeLeft}',
      style: const TextStyle(fontSize: 40),
    );
  }
}
