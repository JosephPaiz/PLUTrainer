import 'package:flutter/material.dart';
import 'package:plu_trainer/Views/home_view.dart';
import 'package:plu_trainer/Views/training_view.dart';
import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';
import 'package:plu_trainer/views/login_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  String? _lastRoute;

  @override
  void initState() {
    super.initState();
    _loadLastRoute();
  }

  Future<void> _loadLastRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final lastRoute = prefs.getString('lastRoute');
    setState(() {
      _lastRoute = lastRoute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: context.read<LoginViewModel>().isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data == true) {
            if (_lastRoute != null && _lastRoute!.isNotEmpty) {
              // Si hay una última ruta almacenada y no es la ruta inicial, navega a esa ruta
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, _lastRoute!);
              });
              return const SizedBox
                  .shrink(); // Evita que cualquier otra UI se muestre.
            } else {
              return TrainingView();
            }
          } else {
            return LoginView(); // Si no está autenticado, muestra la pantalla de inicio de sesión.
          }
        }
      },
    );
  }
}
