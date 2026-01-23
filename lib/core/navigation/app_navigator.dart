import 'package:bmi_tracker/core/di/service_locator.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:bmi_tracker/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:bmi_tracker/features/auth/presentation/screens/login_screen.dart';
import 'package:bmi_tracker/features/auth/presentation/screens/new_password_screen.dart';
import 'package:bmi_tracker/features/auth/presentation/screens/otp_screen.dart';
import 'package:bmi_tracker/features/auth/presentation/screens/signup_screen.dart';
import 'package:bmi_tracker/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppNavigator {
  static final route = GoRouter(
    redirect: (context, state) {
      final authCubit = getIt<AuthCubit>();
      final authState = authCubit.state;
      final isLoggedIn = authState is AuthAuthenticated;

      final isRecovering = authCubit.isRecoveringPassword;
      final isOnAuthRoute =
          state.matchedLocation == LoginScreen.routeName ||
          state.matchedLocation == SignUpScreen.routeName ||
          state.matchedLocation == ForgotPasswordScreen.routeName ||
          state.matchedLocation == OtpScreen.routeName ||
          state.matchedLocation == NewPasswordScreen.routeName;

      if (isRecovering) {
        return null;
      }

      if (!isLoggedIn && !isOnAuthRoute) {
        return LoginScreen.routeName;
      }

      if (isLoggedIn && isOnAuthRoute) {
        return HomeScreen.routeName;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: LoginScreen.routeName,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: SignUpScreen.routeName,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: ForgotPasswordScreen.routeName,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: OtpScreen.routeName,
        builder: (context, state) {
          final email = state.extra as String;
          return OtpScreen(email: email);
        },
      ),
      GoRoute(
        path: NewPasswordScreen.routeName,
        builder: (context, state) => NewPasswordScreen(),
      ),
      GoRoute(
        path: HomeScreen.routeName,
        builder: (context, state) => HomeScreen(),
      ),
    ],
    initialLocation: "/login-screen",
    debugLogDiagnostics: true,
  );
}
