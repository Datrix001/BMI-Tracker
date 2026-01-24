import 'package:bmi_tracker/features/profile/data/data_sources/profile_remote_datasources.dart';
import 'package:bmi_tracker/features/profile/data/model/profile_model.dart';
import 'package:bmi_tracker/features/profile/data/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDatasources remoteDatasources;

  ProfileRepositoryImpl({required this.remoteDatasources});

  @override
  Future<List<BmiModel>> fetchLatestData(String id) {
    return remoteDatasources.fetchLatestData(id);
  }

  @override
  Future<BmiModel?> fetchTodayData(String id) {
    return remoteDatasources.fetchTodayData(id);
  }

  @override
  Future<void> sendData(BmiModel model) {
    return remoteDatasources.sendData(model);
  }
}
