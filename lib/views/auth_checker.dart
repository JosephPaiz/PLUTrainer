import 'package:flutter/material.dart';
import 'package:plu_trainer/Views/home_view.dart';
import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';
import 'package:plu_trainer/views/login_view.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
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
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, _lastRoute!);
              });
              return const SizedBox.shrink();
            } else {
              return const HomeView();
            }
          } else {
            return const LoginView();
          }
        }
      },
    );
  }
}
