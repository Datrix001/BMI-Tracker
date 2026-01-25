import 'package:bmi_tracker/features/profile/data/model/bmi_model.dart';
import 'package:hive/hive.dart';

class ProfileLocalDatasources {
  final Box bmiBox;

  ProfileLocalDatasources({required this.bmiBox});

  Future<void> saveTodayBmi(BmiModel model) async {
    await bmiBox.put('today_bmi', model.toJson());
  }

  BmiModel? getTodayBmi() {
    final data = bmiBox.get("today_bmi");
    if (data == null) return null;
    return BmiModel.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> saveHistoryBmi(List<BmiModel> listModel) async {
    await bmiBox.put("bmi_history", listModel.map((e) => e.toJson()).toList());
  }

  List<BmiModel> getHistoryBmi() {
    final data = bmiBox.get("bmi_history");
    if (data == null) return [];

    return (data as List)
        .map((e) => BmiModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
