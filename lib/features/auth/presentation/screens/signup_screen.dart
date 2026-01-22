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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = "/signup-screen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go("/home-screen");
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
          automaticallyImplyLeading: false,
          title: appTextS1("Register"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 42.w, right: 42.w, top: 70.h),

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
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                child: appTextB1("Enter your password"),
              ),
              CustomFormField(
                hintText: "Enter your password",
                isPassword: true,
                controller: passwordController,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                child: appTextB1("Re-Enter your password"),
              ),
              CustomFormField(
                hintText: "Confirm your password",
                isPassword: true,
                controller: confirmPasswordController,
              ),
              20.verticalSpace,
              CustomButton(onPressed: () {}, buttonText: "Sign Up"),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    appTextB1(
                      "Have an account?",
                      color: AppColors.black.withAlpha(105),
                    ),
                    TextButton(
                      onPressed: () => context.push("/login-screen"),
                      child: appTextB1("Sign In"),
                    ),
                  ],
                ),
              ),
              Center(child: appTextS3("or")),
              10.verticalSpace,
              CustomButton(
                onPressed: () {
                  context.read<AuthCubit>().signInWithGoogle();
                },
                buttonText: "Continue With Google",
                diffButton: true,
                icon: Assets.svg.google,
              ),
              10.verticalSpace,
              CustomButton(
                onPressed: () {
                  context.read<AuthCubit>().signInWithGithub();
                },
                buttonText: "Continue With Github",
                diffButton: true,
                icon: Assets.svg.appleLogo,
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
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
