import 'package:bmi_tracker/features/home/presentation/cubit/bmi_state.dart';
import 'package:bmi_tracker/features/profile/data/repository/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BmiCubit extends Cubit<BmiState> {
  final ProfileRepository repository;
  BmiCubit(this.repository) : super(BmiInitialState());

  Future<void> getHistoricalBmiData(String id) async {
    emit(BmiLoadingState());
    try {
      final bmiData = await repository.fetchLatestData(id);
      print("BMI DATA LENGTH: ${bmiData.length}");
      emit(BmiHistroySuccessState(model: bmiData));
    } catch (e) {
      print("BMI ERROR: $e");
      emit(BmiFailureState(errorMessage: e.toString()));
    }
  }
}
