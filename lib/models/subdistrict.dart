import 'package:json_annotation/json_annotation.dart';

part 'subdistrict.g.dart';

@JsonSerializable()
class Subdistrict {
  @JsonKey(name: 'city_code')
  String cityCode;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String name;

  Subdistrict({
    required this.cityCode,
    required this.code,
    this.id,
    required this.name,
  });

  factory Subdistrict.fromJson(Map<String, dynamic> json) =>
      _$SubdistrictFromJson(json);

  Map<String, dynamic> toJson() => _$SubdistrictToJson(this);
}
