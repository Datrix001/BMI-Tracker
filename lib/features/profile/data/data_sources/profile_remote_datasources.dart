import 'package:bmi_tracker/features/profile/data/model/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRemoteDatasources {
  final SupabaseClient client;

  ProfileRemoteDatasources({required this.client});

  Future<void> sendData(BmiModel model) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    await client
        .from('bmi_history')
        .update(model.toJson())
        .eq('user_id', model.userid)
        .gte('created_at', startOfDay.toIso8601String())
        .lt('created_at', endOfDay.toIso8601String());
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

  Future<BmiModel?> fetchTodayData(String id) async {
    final data = await client
        .from('bmi_history')
        .select()
        .eq('user_id', id)
        .order('created_at', ascending: false)
        .maybeSingle();

    if (data == null) return null;
    return BmiModel.fromJson(data);
  }
}
