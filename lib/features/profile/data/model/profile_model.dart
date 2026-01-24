import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class BmiModel {
  @JsonKey(name: 'user_id')
  final String userid;
  final double weight;
  final double height;
  final double bmi;
  @JsonKey(name: 'created_at')
  final DateTime created_at;

  BmiModel({
    required this.weight,
    required this.height,
    required this.bmi,
    required this.userid,
    required this.created_at,
  });

  factory BmiModel.fromJson(Map<String, dynamic> json) =>
      _$BmiModelFromJson(json);

  Map<String, dynamic> toJson() => _$BmiModelToJson(this);
}
