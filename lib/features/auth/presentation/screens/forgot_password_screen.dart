import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/auth/presentation/widgets/custom_button.dart';
import 'package:bmi_tracker/features/auth/presentation/widgets/custom_form_field.dart';
import 'package:bmi_tracker/gen/assets.gen.dart';
import 'package:bmi_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const routeName = "/forgot-password";

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

final TextEditingController phoneController = TextEditingController();

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: appTextS1("Forgot Password"),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 42.w, right: 42.w, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(Assets.png.forgotP.path, height: 300)),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                child: appTextS1("Forgot Password?"),
              ),
            ),
            appTextB1(
              "Don't worry! it happens. Please enter phone number associated with your account",
              color: AppColors.black.withAlpha(60),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: appTextB2("Enter your phone number"),
            ),
            CustomFormField(
              hintText: "+91 9470435833",
              isPassword: false,
              controller: phoneController,
            ),
            20.verticalSpace,
            CustomButton(onPressed: () {}, buttonText: 'Get OTP'),
          ],
        ),
      ),
    );
  }
}
