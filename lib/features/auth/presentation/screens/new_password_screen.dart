import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:bmi_tracker/features/auth/widgets/custom_button.dart';
import 'package:bmi_tracker/features/auth/widgets/custom_form_field.dart';
import 'package:bmi_tracker/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});
  static const routeName = "/new-password";

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordUpdated) {
          context.go("/login-screen");
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
          title: appTextS1("Set Up New Password"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 42.w, right: 42.w, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(Assets.png.forgotP.path, height: 300.h),
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
              CustomButton(
                onPressed: () {
                  if (passwordController.text.trim() !=
                      confirmPasswordController.text.trim()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: appTextB1("Passwords do not match")),
                    );
                    return;
                  }
                  context.read<AuthCubit>().updatePassword(
                    passwordController.text.trim(),
                  );
                },
                buttonText: "Change Password",
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
