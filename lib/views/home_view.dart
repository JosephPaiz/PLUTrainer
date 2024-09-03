import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plu_trainer/Views/training_view.dart';
import 'package:plu_trainer/views/exam_view.dart';
import 'package:plu_trainer/views/login-view.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: LayoutBuilder(builder: (context, Constraints) {
        if (Constraints.maxWidth < 800) {
          return const Center(
            child: Text(
              'Not yet available for mobile',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          return const Row(
            children: [SidebarMenu(), Expanded(flex: 4, child: TrainingView())],
          );
        }
      }),
    );
  }
}
