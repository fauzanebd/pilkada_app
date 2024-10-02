import 'package:json_annotation/json_annotation.dart';
import 'package:pilkada_app/models/potential_dpt.dart';
import 'package:pilkada_app/models/response/meta.dart';

part 'dpt_response.g.dart';

@JsonSerializable()
class DPTResponse {
  List<PotentialDpt> data;
  bool error;
  String message;
  Meta meta;

  DPTResponse({
    required this.data,
    required this.error,
    required this.message,
    required this.meta,
  });

  factory DPTResponse.fromJson(Map<String, dynamic> json) =>
      _$DPTResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DPTResponseToJson(this);
}
