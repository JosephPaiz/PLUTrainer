import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plu_trainer/core/localization/plutrainer_localizations_esp.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:provider/provider.dart';
import 'package:plu_trainer/viewmodels/Exam/exam_alert_dialog_access_view_model.dart';

class ExamAlertDialogAccess extends StatelessWidget {
  const ExamAlertDialogAccess({super.key});

  @override
  Widget build(BuildContext context) {
    final examAlertDialogViewModel =
        Provider.of<ExamAlertDialogAccessViewModel>(context);

    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 250,
        width: 400,
        decoration: const BoxDecoration(
          color: CustomColors.darkGreen,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
              child: Text(
                'Inserta la superclave que autoriza esta prueba',
                style: Fonts.examAlertDialogText,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: examAlertDialogViewModel.superkeyController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    labelText: LocalizationsEsp.insertSuperKey,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                examAlertDialogViewModel.verifySuperkey();
              },
              child: const Text('Aceptar'),
            ),
            if (examAlertDialogViewModel.message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  examAlertDialogViewModel.message,
                  style: TextStyle(
                      color: examAlertDialogViewModel.hasPermission
                          ? Colors.white
                          : Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
