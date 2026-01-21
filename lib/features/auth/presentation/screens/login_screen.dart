import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/core/styles/app_text_style.dart';
import 'package:bmi_tracker/features/auth/presentation/widgets/custom_button.dart';
import 'package:bmi_tracker/features/auth/presentation/widgets/custom_form_field.dart';
import 'package:bmi_tracker/gen/assets.gen.dart';
import 'package:bmi_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = "/login-screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: appTextS1("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 42.w, right: 42.w, top: 100.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appTextB1("Enter your email"),
            10.verticalSpace,
            CustomFormField(
              hintText: "example@gmail.com",
              isPassword: false,
              controller: emailController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
              child: appTextB1("Enter your password"),
            ),
            CustomFormField(
              hintText: "Enter your password",
              isPassword: true,
              controller: passwordController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
              child: Align(
                alignment: AlignmentGeometry.topRight,
                child: TextButton(
                  onPressed: () => context.push("/forgot-password"),
                  child: appTextB1("Forgot Password?"),
                ),
              ),
            ),
            CustomButton(onPressed: () {}, buttonText: "Login"),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appTextB1(
                    "Don't have an account?",
                    color: AppColors.black.withAlpha(105),
                  ),
                  TextButton(
                    onPressed: () => context.push("/signup-screen"),
                    child: appTextB1(" Sign Up"),
                  ),
                ],
              ),
            ),
            Center(child: appTextS3("or")),
            10.verticalSpace,
            CustomButton(
              onPressed: () {},
              buttonText: "Continue With Google",
              diffButton: true,
              icon: Assets.svg.google,
            ),
            10.verticalSpace,
            CustomButton(
              onPressed: () {},
              buttonText: "Continue With Apple",
              diffButton: true,
              icon: Assets.svg.appleLogo,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
