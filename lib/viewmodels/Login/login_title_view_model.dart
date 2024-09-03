import 'package:flutter/material.dart';

class LoginTitleViewModel extends ChangeNotifier {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  Animation<double> get scaleAnimation => _scaleAnimation;
  Animation<double> get fadeAnimation => _fadeAnimation;

  void initialize(TickerProvider vsync) {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: vsync,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
