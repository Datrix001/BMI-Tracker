import 'package:bmi_tracker/features/profile/data/model/bmi_model.dart';
import 'package:bmi_tracker/features/profile/data/repository/profile_repository.dart';
import 'package:bmi_tracker/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final user = Supabase.instance.client.auth.currentUser;
  final ProfileRepository repository;

  ProfileCubit(this.repository) : super(ProfileInitial());

  Future<void> getUserLatestData(String id) async {
    emit(ProfileLoading());
    try {
      final profile = await repository.fetchLatestData(id);
      emit(ProfileLoadedSuccess(model: profile));
    } catch (e) {
      emit(ProfileFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getUserTodayData(String id) async {
    emit(ProfileLoading());
    try {
      final profile = await repository.fetchTodayData(id);
      emit(ProfileTodayDataLoadedSuccess(model: profile));
    } catch (e) {
      emit(ProfileFailure(errorMessage: e.toString()));
    }
  }

  Future<void> sendData(BmiModel model) async {
    emit(ProfileLoading());
    try {
      await repository.sendData(model);
      final todayData = await repository.fetchTodayData(model.userid);
      emit(ProfileTodayDataLoadedSuccess(model: todayData));
      // emit(ProfileSentSuccess());
    } catch (e) {
      emit(ProfileFailure(errorMessage: e.toString()));
    }
  }
}
