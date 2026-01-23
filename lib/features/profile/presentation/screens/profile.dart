import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:bmi_tracker/features/profile/presentation/widgets/Custom_icon_button.dart';
import 'package:bmi_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = "/profile-screen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go("/login-screen");
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: appTextB1(state.errorMessage)));
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 42.w, right: 42.w, top: 30.h),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 80.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(90.r),
                ),
                child: Icon(Icons.person, color: AppColors.white, size: 70.3.h),
              ),
            ),
            20.verticalSpace,
            CustomIconButton(
              onTap: () => context.push("/edit-profile"),
              buttonText: "Edit Profile",
              icon: Icons.person,
            ),

            CustomIconButton(
              onTap: () => context.read<AuthCubit>().signOut(),
              buttonText: "Logout",
              icon: Icons.person,
            ),
          ],
        ),
      ),
    );
  }
}
