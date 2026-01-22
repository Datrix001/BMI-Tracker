import 'package:bmi_tracker/core/di/service_locator.dart';
import 'package:bmi_tracker/core/navigation/app_navigator.dart';
import 'package:flutter/material.dart';
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
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: AppNavigator.route,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
