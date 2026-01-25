import 'package:bmi_tracker/features/profile/data/model/bmi_model.dart';

abstract class ProfileRepository {
  Future<void> sendData(BmiModel model);
  Future<List<BmiModel>> fetchLatestData(String id);
  Future<BmiModel?> fetchTodayData(String id);
  Future<void> sendProfileData({
    required String email,
    required String name,
    required String id,
  });
}
