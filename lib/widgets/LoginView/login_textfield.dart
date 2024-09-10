import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plu_trainer/core/localization/plutrainer_localizations_esp.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';

class LoginTextfield extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String) onSubmitted;
  const LoginTextfield({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  State<LoginTextfield> createState() => _LoginTextfieldState();
}

class _LoginTextfieldState extends State<LoginTextfield> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: const TextStyle(color: CustomColors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: CustomColors.deepDarkGrey,
          labelText: LocalizationsEsp.enterYourSuperKey,
          labelStyle: const TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: CustomColors.lightGreen,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: CustomColors.lightGreen,
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
