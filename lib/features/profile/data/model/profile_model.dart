import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class BmiModel {
  @JsonKey(name: 'user_id')
  final String userid;
  final double weight;
  final double height;
  final double bmi;

  BmiModel({
    required this.weight,
    required this.height,
    required this.bmi,
    required this.userid,
  });

  factory BmiModel.fromJson(Map<String, dynamic> json) =>
      _$BmiModelFromJson(json);

  Map<String, dynamic> toJson() => _$BmiModelToJson(this);
}
