import 'package:bmi_tracker/features/profile/data/model/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRemoteDatasources {
  final SupabaseClient client;

  ProfileRemoteDatasources({required this.client});

  // Future<void> sendData(BmiModel model) async {
  //   final today = await client
  //       .from('bmi_history')
  //       .select('id')
  //       .eq('user_id', model.userid)
  //       .gte('created_at', 'now()::date')
  //       .lt('created_at', 'now()::date + interval \'1 day\'')
  //       .maybeSingle();

  //   final data = {
  //     'user_id': model.userid,
  //     'weight': model.weight,
  //     'height': model.height,
  //     'bmi': model.bmi,
  //   };

  //   if (today == null) {
  //     // ➕ FIRST TIME TODAY
  //     await client.from('bmi_history').insert(data);
  //   } else {
  //     // ✏️ EDIT TODAY
  //     await client.from('bmi_history').update(data).eq('id', today['id']);
  //   }
  // }

  Future<void> updateTodayData(BmiModel model) async {
    final nowUtc = DateTime.now().toUtc();
    final startOfDayUtc = DateTime.utc(nowUtc.year, nowUtc.month, nowUtc.day);
    final endOfDayUtc = startOfDayUtc.add(const Duration(days: 1));

    final data = {
      'weight': model.weight,
      'height': model.height,
      'bmi': model.bmi,
    };

    await client
        .from('bmi_history')
        .update(data)
        .eq('user_id', model.userid)
        .gte('created_at', startOfDayUtc.toIso8601String())
        .lt('created_at', endOfDayUtc.toIso8601String());
  }

  Future<List<BmiModel>> fetchLatestData(String id) async {
    final data = await client
        .from('bmi_history')
        .select()
        .eq('user_id', id)
        .order('created_at', ascending: false)
        .limit(7);
    return data.map<BmiModel>((e) => BmiModel.fromJson(e)).toList();
  }

  Future<BmiModel?> fetchTodayData(String userId) async {
    final nowUtc = DateTime.now().toUtc();
    final startOfDayUtc = DateTime.utc(nowUtc.year, nowUtc.month, nowUtc.day);
    final endOfDayUtc = startOfDayUtc.add(const Duration(days: 1));

    final data = await client
        .from('bmi_history')
        .select()
        .eq('user_id', userId)
        .gte('created_at', startOfDayUtc.toIso8601String())
        .lt('created_at', endOfDayUtc.toIso8601String())
        .order('created_at', ascending: false)
        .limit(1);

    if (data.isEmpty) return null;
    return BmiModel.fromJson(data.first);
  }

  Future<void> sendProfileData({
    required String name,
    required String email,
    required String id,
  }) async {
    final existing = await client
        .from('profile')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (existing != null) return;

    await client.from('profile').insert({
      'id': id,
      'email': email,
      'name': name,
    });
  }
}
