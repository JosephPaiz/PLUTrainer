import 'package:flutter/material.dart';
import 'package:plu_trainer/style/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Fonts {
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
}
