import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Fonts {
  static final TextStyle loginTitle = GoogleFonts.nunito(
      fontSize: 50, fontWeight: FontWeight.w700, color: CustomColors.white);

  static final TextStyle amRed = GoogleFonts.nunito(
      fontSize: 60, fontWeight: FontWeight.w800, color: Colors.red[400]);

  static final TextStyle amGreen = GoogleFonts.nunito(
      fontSize: 60, fontWeight: FontWeight.w800, color: Colors.green[500]);

  static final TextStyle toAccesEnterYourSuperKey = GoogleFonts.nunito(
      fontSize: 20, fontWeight: FontWeight.w700, color: CustomColors.white);

  static final TextStyle title = GoogleFonts.exo2(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: CustomColors.black,
  );

  static final TextStyle buttonTextWhite = GoogleFonts.roboto(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: CustomColors.white,
  );

  static final TextStyle buttonTextGrey = GoogleFonts.roboto(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: CustomColors.grey,
  );

  static final TextStyle trainingOptionButtonText = GoogleFonts.nunito(
      fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black);

  static final TextStyle trainingOptionButtonDescription = GoogleFonts.nunito(
      fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black);
}
