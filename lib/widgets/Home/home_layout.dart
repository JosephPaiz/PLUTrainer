import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/widgets/Home/test_widget.dart';

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
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              color: CustomColors.grey,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: const InformationCardWidget(
                  title: 'Respuestas Correctas',
                  description: 'Porcentaje de respuestas correctas',
                  number: '1/10',
                  backGroundColor: Color(0xFF675DF5),
                  icon: Icons.check_circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
