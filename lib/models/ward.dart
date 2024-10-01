import 'package:json_annotation/json_annotation.dart';

part 'ward.g.dart';

@JsonSerializable()
class Ward {
  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'subdistrict_code')
  String subdistrictCode;

  Ward({
    required this.code,
    this.id,
    required this.name,
    required this.subdistrictCode,
  });

  factory Ward.fromJson(Map<String, dynamic> json) => _$WardFromJson(json);

  Map<String, dynamic> toJson() => _$WardToJson(this);
}
