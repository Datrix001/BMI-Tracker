import 'package:bmi_tracker/features/profile/data/data_sources/profile_local_datasources.dart';
import 'package:bmi_tracker/features/profile/data/data_sources/profile_remote_datasources.dart';
import 'package:bmi_tracker/features/profile/data/model/bmi_model.dart';
import 'package:bmi_tracker/features/profile/data/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDatasources remoteDatasources;
  final ProfileLocalDatasources localDatasources;

  ProfileRepositoryImpl({
    required this.remoteDatasources,
    required this.localDatasources,
  });

  @override
  Future<List<BmiModel>> fetchLatestData(String id) async {
    try {
      final remote = await remoteDatasources.fetchLatestData(id);
      await localDatasources.saveHistoryBmi(remote);
      return remote;
    } catch (_) {
      return localDatasources.getHistoryBmi();
    }
  }

  @override
  Future<BmiModel?> fetchTodayData(String id) async {
    try {
      final remote = await remoteDatasources.fetchTodayData(id);
      if (remote != null) {
        await localDatasources.saveTodayBmi(remote);
        return remote;
      }
    } catch (e) {
      print('fetchTodayData failed: $e');
    }

    return localDatasources.getTodayBmi();
  }

  @override
  Future<void> sendData(BmiModel model) async {
    await remoteDatasources.upsertTodayData(model);
    await localDatasources.saveTodayBmi(model);
  }

  @override
  Future<void> sendProfileData({
    required String email,
    required String name,
    required String id,
  }) async {
    return await remoteDatasources.sendProfileData(
      email: email,
      name: name,
      id: id,
    );
  }
}
