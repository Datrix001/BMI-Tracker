import 'package:bmi_tracker/features/auth/data/datasources/auth_remote_datsource.dart';
import 'package:bmi_tracker/features/auth/data/repository/auth_repository.dart';
import 'package:bmi_tracker/features/auth/data/repository/auth_repository_impl.dart';
import 'package:bmi_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bmi_tracker/features/home/presentation/cubit/bmi_cubit.dart';
import 'package:bmi_tracker/features/home/presentation/cubit/home_cubit.dart';
import 'package:bmi_tracker/features/profile/data/data_sources/profile_remote_datasources.dart';
import 'package:bmi_tracker/features/profile/data/repository/profile_repository.dart';
import 'package:bmi_tracker/features/profile/data/repository/profile_repository_impl.dart';
import 'package:bmi_tracker/features/profile/presentation/cubit/profile_cubit.dart';
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
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<ProfileRemoteDatasources>(
    () => ProfileRemoteDatasources(client: getIt<SupabaseClient>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDatasources: getIt<ProfileRemoteDatasources>(),
    ),
  );
  getIt.registerLazySingleton<ProfileCubit>(
    () => ProfileCubit(getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton<HomeCubit>(
    () => HomeCubit(getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton<BmiCubit>(
    () => BmiCubit(getIt<ProfileRepository>()),
  );
}
