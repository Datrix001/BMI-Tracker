import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final IconData icon;
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 30.h,
              width: 30.h,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: AppColors.white),
            ),
            30.horizontalSpace,
            appTextS4(buttonText),
          ],
        ),
      ),
    );
  }
}
