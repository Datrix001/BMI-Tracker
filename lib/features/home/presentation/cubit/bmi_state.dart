import 'package:bmi_tracker/features/profile/data/model/profile_model.dart';

abstract class BmiState {}

class BmiInitialState extends BmiState {}

class BmiLoadingState extends BmiState {}

class BmiHistroySuccessState extends BmiState {
  final List<BmiModel?> model;

  BmiHistroySuccessState({required this.model});
}

class BmiFailureState extends BmiState {
  final String errorMessage;

  BmiFailureState({required this.errorMessage});
}
