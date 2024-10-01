import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'province_code')
  String provinceCode;

  City({
    required this.code,
    this.id,
    required this.name,
    required this.provinceCode,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
