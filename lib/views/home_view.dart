import 'package:flutter/material.dart';
import 'package:plu_trainer/Views/training_view.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Row(
        children: [SidebarMenu(), Expanded(flex: 4, child: TrainingView())],
      ),
    );
  }
}
