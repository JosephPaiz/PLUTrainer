import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/viewmodels/Login/login_title_view_model.dart';
import 'package:provider/provider.dart';

class LoginTitleAM extends StatefulWidget {
  const LoginTitleAM({super.key});

  @override
  State<LoginTitleAM> createState() => _LoginTitleAMState();
}

class _LoginTitleAMState extends State<LoginTitleAM>
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'A', style: Fonts.amRed),
                TextSpan(text: 'M', style: Fonts.amGreen),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
