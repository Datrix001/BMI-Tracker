import 'package:bmi_tracker/features/profile/data/model/bmi_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSucess extends HomeState {}

class HomeDataSuccessfully extends HomeState {
  final BmiModel? model;
  HomeDataSuccessfully({required this.model});
}

class LatestHomeDataSuccessfully extends HomeState {
  final List<BmiModel?> model;

  LatestHomeDataSuccessfully({required this.model});
}

class HomeDataFailure extends HomeState {
  final String errorMessage;

  HomeDataFailure({required this.errorMessage});
}
