import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static final donnerText = GoogleFonts.calligraffitti(
    fontSize: 36.0,
    color: AppColors.backgroundColor,
    fontWeight: FontWeight.w400,
  );

  static final primaryBtnOutlinedText = GoogleFonts.inter(
    fontSize: 18.0,
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
  );

  static final secondaryBtnOutlinedText = GoogleFonts.inter(
    fontSize: 18.0,
    color: AppColors.secondary,
    fontWeight: FontWeight.w500,
  );

  static final btnFillText = GoogleFonts.inter(
    fontSize: 18.0,
    color: AppColors.backgroundColor,
    fontWeight: FontWeight.w500,
  );

  static final pageTitleText = GoogleFonts.robotoSlab(
    fontSize: 28.0,
    color: AppColors.primary,
    fontWeight: FontWeight.w700,
  );
  static final secondaryPageTitleText = GoogleFonts.robotoSlab(
    fontSize: 28.0,
    color: AppColors.secondary,
    fontWeight: FontWeight.w700,
  );
  static final inputText = GoogleFonts.inter(
    fontSize: 15.0,
    color: AppColors.inputTextColor,
    fontWeight: FontWeight.w400,
  );

  static final bodyText = GoogleFonts.inter(
    fontSize: 16.0,
    color: AppColors.bodyTextColor,
    fontWeight: FontWeight.w400,
  );

  static final bodyTextBlack = GoogleFonts.inter(
    fontSize: 16.0,
    color: AppColors.textTitleColor,
    fontWeight: FontWeight.w400,
  );

    static final bodyTextSmall = GoogleFonts.inter(
    fontSize: 12.0,
    color: AppColors.textTitleColor,
    fontWeight: FontWeight.w400,
  );

  static final linkTextSmall = GoogleFonts.inter(
    fontSize: 12.0,
    color: AppColors.secondary,
    fontWeight: FontWeight.w400,
  );

  static final appBarText = GoogleFonts.workSans(
    fontSize: 20.0,
    color: AppColors.backgroundColor,
    fontWeight: FontWeight.w700,
  );
  static final headerText = GoogleFonts.inter(
    fontSize: 20.0,
    color: AppColors.headerTextColor,
    fontWeight: FontWeight.w500,
  );
  static final cardText = GoogleFonts.inter(
      fontSize: 14.0,
      color: AppColors.headerTextColor,
      fontWeight: FontWeight.w400);
}
