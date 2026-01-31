import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomDialogBox extends StatelessWidget {
  final String yesText;
  final String noText;
  final String aboutText;
  final VoidCallback onPressed;
  const CustomDialogBox({
    super.key,
    required this.yesText,
    required this.noText,
    required this.onPressed,
    required this.aboutText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200.h,
        width: 200.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Center(child: appTextS2("Logout")),
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                child: appTextB1(aboutText),
              ),
              CustomButton(onPressed: onPressed, buttonText: yesText),
              10.verticalSpace,
              CustomButton(
                onPressed: context.pop,
                buttonText: noText,
                diffButton: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
