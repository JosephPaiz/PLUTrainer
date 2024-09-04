import 'package:flutter/material.dart';

import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';

class TrainYourEyesightView extends StatefulWidget {
  const TrainYourEyesightView({super.key});

  @override
  State<TrainYourEyesightView> createState() => _HomeViewState();
}

class _HomeViewState extends State<TrainYourEyesightView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
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
                child: Container(
                  color: Colors.green,
                  child: const Text('Train Your Eyesight'),
                ),
              )
            ],
          );
        }
      }),
    );
  }
}
