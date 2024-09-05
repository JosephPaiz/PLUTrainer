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
    fontSize: 15.0,
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

  static final TextStyle trainingOptionButtonText = GoogleFonts.comfortaa(
      fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white);

  static final TextStyle trainingOptionButtonDescription =
      GoogleFonts.comfortaa(
          fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black);

  static final TextStyle timerTextStyle = GoogleFonts.rubik(
      fontSize: 40, fontWeight: FontWeight.w500, color: Colors.black);

  static final TextStyle stopWatchTextStyle = GoogleFonts.rubik(
      fontSize: 40, fontWeight: FontWeight.w500, color: Colors.black);

  static final TextStyle sidebarTitleTextStyle = GoogleFonts.comfortaa(
      fontSize: 24, fontWeight: FontWeight.w800, color: Colors.grey[600]);

  static final TextStyle pluListTextStyle = GoogleFonts.comfortaa(
      fontWeight: FontWeight.w800, color: Colors.grey[600]);
  static final TextStyle historyProfileText =
      GoogleFonts.comfortaa(fontWeight: FontWeight.w800, color: Colors.white);

  static final TextStyle sideBarButtonTextStyleActive =
      GoogleFonts.comfortaa(fontWeight: FontWeight.w800, color: Colors.white);

  static final TextStyle sideBarButtonTextStyledesactive =
      GoogleFonts.comfortaa(
          fontWeight: FontWeight.w800, color: Colors.grey[600]);

  static final TextStyle scoreViewTitleTexStyle = GoogleFonts.comfortaa(
      fontSize: 30, fontWeight: FontWeight.w800, color: Colors.black);

  static final TextStyle historyViewTitleTextStyle = GoogleFonts.comfortaa(
      fontSize: 35, fontWeight: FontWeight.w800, color: Colors.black);
  static final TextStyle noHistoryExistTextStyle = GoogleFonts.comfortaa(
      fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black);
}
