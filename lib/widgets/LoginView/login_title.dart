import 'package:flutter/material.dart';
import 'package:plu_trainer/core/localization/plutrainer_localizations_esp.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/viewmodels/Login/login_title_view_model.dart';
import 'package:provider/provider.dart';

class LoginTitle extends StatefulWidget {
  const LoginTitle({super.key});

  @override
  State<LoginTitle> createState() => _LoginTitleState();
}

class _LoginTitleState extends State<LoginTitle>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<LoginTitleViewModel>(context, listen: false).initialize(this);
  }

  @override
  void dispose() {
    Provider.of<LoginTitleViewModel>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginTitleViewModel loginTitleViewModel =
        Provider.of<LoginTitleViewModel>(context);

    return ScaleTransition(
      scale: loginTitleViewModel.scaleAnimation,
      child: FadeTransition(
        opacity: loginTitleViewModel.fadeAnimation,
        child: Text(
          LocalizationsEsp.welcomeToPlUTrainer,
          style: Fonts.loginTitle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
