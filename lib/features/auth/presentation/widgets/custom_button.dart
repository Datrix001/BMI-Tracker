import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool diffButton;
  final String? icon;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.diffButton = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 40.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.w, color: AppColors.black.withAlpha(30)),
            borderRadius: BorderRadius.circular(15.r),
          ),
          backgroundColor: diffButton ? AppColors.transparent : AppColors.black,
          shadowColor: AppColors.transparent,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) SvgPicture.asset(icon!),
            8.horizontalSpace,
            appTextB1(
              buttonText,
              color: diffButton ? AppColors.black : AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
