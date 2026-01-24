import 'package:bmi_tracker/features/profile/data/model/profile_model.dart';

abstract class ProfileRepository {
  Future<void> sendData(BmiModel model);
  Future<List<BmiModel>> fetchLatestData(String id);
  Future<BmiModel?> fetchTodayData(String id);
}
