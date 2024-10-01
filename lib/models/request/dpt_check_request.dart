import 'package:json_annotation/json_annotation.dart';

part 'dpt_check_request.g.dart';

@JsonSerializable()
class DPTCheckRequest {
  @JsonKey(name: 'ward_code')
  String wardCode;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'gender')
  String gender;

  DPTCheckRequest({
    required this.wardCode,
    required this.name,
    required this.gender,
  });

  factory DPTCheckRequest.fromJson(Map<String, dynamic> json) =>
      _$DPTCheckRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DPTCheckRequestToJson(this);
}
