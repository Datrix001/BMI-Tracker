import 'package:bmi_tracker/features/home/presentation/cubit/home_state.dart';
import 'package:bmi_tracker/features/profile/data/model/profile_model.dart';
import 'package:bmi_tracker/features/profile/data/repository/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeCubit extends Cubit<HomeState> {
  final ProfileRepository repository;
  HomeCubit(this.repository) : super(HomeInitial());

  Future<void> getData(String id) async {
    emit(HomeLoading());
    try {
      final data = await repository.fetchTodayData(id);
      emit(HomeDataSuccessfully(model: data));
    } catch (e) {
      emit(HomeDataFailure(errorMessage: e.toString()));
    }
  }

  Future<void> sendData(BmiModel model) async {
    emit(HomeLoading());
    try {
      await repository.sendData(model);
      final data = await repository.fetchTodayData(model.userid);
      emit(HomeDataSuccessfully(model: data));
    } catch (e) {
      emit(HomeDataFailure(errorMessage: e.toString()));
    }
  }

  Future<void> sendProfileData() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return;

      await repository.sendProfileData(
        email: user.email ?? '',
        name:
            user.userMetadata?['name'] ?? user.userMetadata?['full_name'] ?? '',
        id: user.id,
      );
    } catch (_) {}
  }
}
