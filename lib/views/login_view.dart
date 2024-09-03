import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plu_trainer/core/localization/plutrainer_localizations_esp.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';
import 'package:plu_trainer/widgets/LoginView/login_textfield.dart';
import 'package:plu_trainer/widgets/LoginView/login_title.dart';
import 'package:plu_trainer/widgets/LoginView/login_title_am.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _superkeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      body: Container(
        color: CustomColors.green,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [LoginTitle(), SizedBox(width: 20), LoginTitleAM()],
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocalizationsEsp.toAccesEnterYourSuperKEy,
                    style: Fonts.toAccesEnterYourSuperKey,
                  ),
                  LoginTextfield(
                    controller: _superkeyController,
                    onSubmitted: (value) {
                      final superkey = int.tryParse(value);
                      if (superkey != null) {
                        loginViewModel.verifySuperkey(superkey, context);
                      } else {
                        // Manejar el error de entrada aquí si es necesario
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
