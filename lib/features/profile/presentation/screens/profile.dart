import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:bmi_tracker/features/profile/presentation/widgets/Custom_icon_button.dart';
import 'package:bmi_tracker/features/profile/presentation/widgets/custom_dialog_box.dart';
import 'package:bmi_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = "/profile-screen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = Supabase.instance.client.auth.currentUser;

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
                width: 90.w,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(90.r),
                ),
                child: user?.userMetadata?['avatar_url'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(50.r),
                        child: Image.network(user?.userMetadata?['avatar_url']),
                      )
                    : Icon(Icons.person, color: AppColors.white, size: 70.3.h),
              ),
            ),
            10.verticalSpace,
            appTextB1(user?.userMetadata!['name'] ?? ""),
            20.verticalSpace,
            CustomIconButton(
              onTap: () => context.push("/edit-bmi"),
              buttonText: "Edit Today's BMI",
              icon: Icons.person,
            ),

            CustomIconButton(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return CustomDialogBox(
                      aboutText: "Are you Sure?",
                      yesText: "Yes",
                      noText: "No",
                      onPressed: () => context.read<AuthCubit>().signOut(),
                    );
                  },
                );
              },
              buttonText: "Logout",
              icon: Icons.logout_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
