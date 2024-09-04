import 'package:flutter/material.dart';

import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';

class TrainYourMindView extends StatefulWidget {
  const TrainYourMindView({super.key});

  @override
  State<TrainYourMindView> createState() => _HomeViewState();
}

class _HomeViewState extends State<TrainYourMindView> {
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
                  child: const Text('Train your Mind'),
                ),
              )
            ],
          );
        }
      }),
    );
  }
}
