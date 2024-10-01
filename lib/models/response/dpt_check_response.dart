import 'package:json_annotation/json_annotation.dart';
import 'package:pilkada_app/models/potential_dpt.dart';

part 'dpt_check_response.g.dart';

@JsonSerializable()
class DPTCheckResponse {
  @JsonKey(name: 'is_valid_dpt')
  bool isValidDpt;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'potential_dpt')
  List<PotentialDpt> potentialDpt;

  DPTCheckResponse({
    required this.isValidDpt,
    required this.message,
    required this.potentialDpt,
  });

  factory DPTCheckResponse.fromJson(Map<String, dynamic> json) =>
      _$DPTCheckResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DPTCheckResponseToJson(this);
}
