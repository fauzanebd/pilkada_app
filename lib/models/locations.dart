import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class Locations {
  String? city;
  String? province;
  String? subdistrict;
  String? ward;

  Locations({
    this.city,
    this.province,
    this.subdistrict,
    this.ward,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationsToJson(this);
}
