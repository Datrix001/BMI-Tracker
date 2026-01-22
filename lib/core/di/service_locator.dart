import 'package:bmi_tracker/features/auth/data/datasources/auth_remote_datsource.dart';
import 'package:bmi_tracker/features/auth/data/repository/auth_repository.dart';
import 'package:bmi_tracker/features/auth/data/repository/auth_repository_impl.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> loadDependencies() async {
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  getIt.registerLazySingleton<AuthRemoteDatsource>(
    () => AuthRemoteDatsource(getIt<SupabaseClient>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDatsource: getIt<AuthRemoteDatsource>()),
  );
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepository>()));
}
