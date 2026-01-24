// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BmiModel _$BmiModelFromJson(Map<String, dynamic> json) => BmiModel(
  weight: (json['weight'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  bmi: (json['bmi'] as num).toDouble(),
  userid: json['user_id'] as String,
  created_at: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$BmiModelToJson(BmiModel instance) => <String, dynamic>{
  'user_id': instance.userid,
  'weight': instance.weight,
  'height': instance.height,
  'bmi': instance.bmi,
  'created_at': instance.created_at.toIso8601String(),
};
