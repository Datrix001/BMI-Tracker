import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:bmi_tracker/features/auth/presentation/widgets/custom_button.dart';
import 'package:bmi_tracker/gen/assets.gen.dart';
import 'package:bmi_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});
  static const routeName = "/otp-screen";

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // final ValueNotifier<bool> isAvailable = ValueNotifier(false);
  final TextEditingController otp = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 20), () {
    //   if (!mounted) return;
    //   isAvailable.value = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpVerifies) {
          context.go("/new-password");
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: appTextB1(state.errorMessage)));
        }
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: appTextS1("Verify"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 42.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Center(
                  child: Image.asset(Assets.png.opt.path, height: 250.h),
                ),
              ),
              appTextS1("Enter OTP"),
              appTextB1("An 4 digit OTP has been sent to"),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Pinput(
                  controller: otp,
                  length: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              CustomButton(
                onPressed: () {
                  context.read<AuthCubit>().sendToken(widget.email, otp.text);
                },
                buttonText: "Verify",
              ),
              20.verticalSpace,
              // ValueListenableBuilder<bool>(
              //   valueListenable: isAvailable,
              //   builder: (context, isAvailable, _) {
              //     return isAvailable
              //         ? TextButton(
              //             onPressed: () {},
              //             child: appTextB1("Resend OTP"),
              //           )
              //         : appTextB1(
              //             "Resend OTP",
              //             color: AppColors.black.withAlpha(80),
              //           );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // isAvailable.dispose();
    super.dispose();
  }
}
