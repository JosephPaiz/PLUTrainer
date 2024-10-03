import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/widgets/Home/ChartMenu/chart_menu.dart';
import 'package:plu_trainer/widgets/Home/InformationCard/information_card_menu.dart';
import 'package:provider/provider.dart';
import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _AnimatedTextOverlayState();
}

class _AnimatedTextOverlayState extends State<HomeLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    final superkey = loginViewModel.superkeyValue;

    if (superkey == null) {
      return const Center(
        child: Text('No se encontró la superkey. Por favor, inicie sesión.'),
      );
    }

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              color: CustomColors.grey,
              width: double.infinity,
              height: double.infinity,
            ),
            FadeTransition(
              opacity: _opacityAnimation,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InformationCardMenu(),
                    ChartMenu(
                      percentValues: [10, 50, 20, 20],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
