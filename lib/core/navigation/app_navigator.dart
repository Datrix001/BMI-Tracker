import 'package:bmi_tracker/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:bmi_tracker/features/auth/presentation/screens/login_screen.dart';
import 'package:bmi_tracker/features/auth/presentation/screens/new_password_screen.dart';
import 'package:bmi_tracker/features/auth/presentation/screens/otp_screen.dart';
import 'package:bmi_tracker/features/auth/presentation/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';

class AppNavigator {
  static final route = GoRouter(
    routes: [
      GoRoute(
        path: "/login-screen",
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: "/signup-screen",
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: "/forgot-password",
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(path: "/otp-screen", builder: (context, state) => OtpScreen()),
      GoRoute(
        path: "/new-password",
        builder: (context, state) => NewPasswordScreen(),
      ),
    ],
    initialLocation: "/login-screen",
    debugLogDiagnostics: true,
  );
}
