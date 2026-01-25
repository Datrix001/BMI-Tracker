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

  Future<void> upsertTodayData(BmiModel model) async {
    final nowUtc = DateTime.now().toUtc();
    final start = DateTime.utc(nowUtc.year, nowUtc.month, nowUtc.day);
    final end = start.add(const Duration(days: 1));

    final existing = await client
        .from('bmi_history')
        .select('id')
        .eq('user_id', model.userid)
        .gte('created_at', start.toIso8601String())
        .lt('created_at', end.toIso8601String())
        .maybeSingle();

    final payload = {
      'user_id': model.userid,
      'weight': model.weight,
      'height': model.height,
      'bmi': model.bmi,
    };

    if (existing == null) {
      print("➕ inserting today's BMI");
      await client.from('bmi_history').insert(payload);
    } else {
      print("✏️ updating today's BMI");
      await client.from('bmi_history').update(payload).eq('id', existing['id']);
    }
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
    required String id,
    required String email,
    required String name,
  }) async {
    try {
      print("➕ inserting profile for $id");

      await client.from('profile').insert({
        'id': id,
        'email': email,
        'name': name,
      });

      print("✅ profile inserted");
    } catch (e) {
      // Duplicate key = profile already exists → totally fine
      print("ℹ️ profile already exists, skipping insert");
    }
  }
}
