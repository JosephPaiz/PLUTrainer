import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plu_trainer/core/localization/plutrainer_localizations_esp.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/widgets/LoginView/login_textfield.dart';
import 'package:plu_trainer/widgets/LoginView/login_title.dart';
import 'package:plu_trainer/widgets/LoginView/login_title_am.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                LoginTextfield()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
