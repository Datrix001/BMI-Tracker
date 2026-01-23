import 'package:bmi_tracker/core/di/service_locator.dart';
import 'package:bmi_tracker/core/navigation/app_navigator.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: '${dotenv.env['SUPABASE_URL']}',
    anonKey: "${dotenv.env['SUPABASE_ANNO_KEY']}",
  );

  await loadDependencies();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider<AuthCubit>.value(value: getIt<AuthCubit>())],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return Builder(
          builder: (context) {
            return MaterialApp.router(
              routerConfig: AppNavigator.route,
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}
