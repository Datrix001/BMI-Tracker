import 'dart:math';

import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:bmi_tracker/features/auth/presentation/widgets/custom_button.dart';
import 'package:bmi_tracker/features/auth/presentation/widgets/custom_form_field.dart';
import 'package:bmi_tracker/gen/assets.gen.dart';
import 'package:bmi_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const routeName = "/forgot-password";

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordResetEmailSent) {
          context.push("/otp-screen", extra: emailController.text);
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: appTextB1(state.errorMessage)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: appTextS1("Forgot Password"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 42.w, right: 42.w, top: 20.h),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(Assets.png.forgotP.path, height: 300.h),
              ),
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

              20.verticalSpace,
              CustomFormField(
                hintText: "Enter your email id",
                isPassword: false,
                controller: emailController,
              ),
              20.verticalSpace,
              CustomButton(
                onPressed: () {
                  context.read<AuthCubit>().sendPasswordResetEmail(
                    emailController.text,
                  );
                },
                buttonText: 'Get OTP',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
