import 'package:flutter/material.dart';
import 'package:plu_trainer/viewmodels/Training/stop_watch_view_model.dart';
import 'package:provider/provider.dart';

class StopWatchView extends StatefulWidget {
  const StopWatchView({super.key});

  @override
  State<StopWatchView> createState() => _StopWatchViewState();
}

class _StopWatchViewState extends State<StopWatchView> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final StopWatchViewViewModel = Provider.of<StopWatchViewModel>(context);
    return Text(
      StopWatchViewViewModel.formattedTime,
      style: const TextStyle(fontSize: 40),
    );
  }
}
