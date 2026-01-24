import 'package:bmi_tracker/features/profile/data/model/profile_model.dart';

sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoadedSuccess extends ProfileState {
  final List<BmiModel> model;

  ProfileLoadedSuccess({required this.model});
}

class ProfileTodayDataLoadedSuccess extends ProfileState {
  final BmiModel? model;

  ProfileTodayDataLoadedSuccess({required this.model});
}

class ProfileSentSuccess extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String errorMessage;

  ProfileFailure({required this.errorMessage});
}
