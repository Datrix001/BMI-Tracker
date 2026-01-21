import 'package:bmi_tracker/core/styles/text_size.dart';
import 'package:bmi_tracker/gen/colors.gen.dart';
import 'package:bmi_tracker/gen/fonts.gen.dart';

import 'package:flutter/painting.dart';

final class AppTextStyles {
  AppTextStyles._();

  static final h1 = TextStyle(
    fontFamily: FontFamily.sourceCodePro,
    fontSize: AppFontSize.size40,
    // fontWeight: FontWeight.w900,
    color: AppColors.black,
  );

  static final h2 = TextStyle(
    fontFamily: FontFamily.sourceCodePro,

    fontSize: AppFontSize.size32,
    // fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static final h3 = TextStyle(
    fontFamily: FontFamily.sourceCodePro,

    fontSize: AppFontSize.size20,
    // fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static final s1 = TextStyle(
    fontFamily: FontFamily.sourceCodePro,
    fontSize: AppFontSize.size24,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static final s2 = TextStyle(
    fontFamily: FontFamily.sourceCodePro,
    fontSize: AppFontSize.size20,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static final s3 = TextStyle(
    fontFamily: FontFamily.sourceCodePro,
    fontSize: AppFontSize.size16,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static final s4 = TextStyle(
    fontFamily: FontFamily.sourceCodePro,
    fontSize: AppFontSize.size16,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static final b1 = TextStyle(
    fontFamily: FontFamily.sourceCodePro,
    fontSize: AppFontSize.size14,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static final b2 = TextStyle(
    fontFamily: FontFamily.sourceCodePro,
    fontSize: AppFontSize.size12,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
}
