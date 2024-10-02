import 'package:json_annotation/json_annotation.dart';

part 'potential_dpt.g.dart';

@JsonSerializable()
class PotentialDpt {
  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'age')
  int? age;

  @JsonKey(name: 'city_code')
  String? cityCode;

  @JsonKey(name: 'city_name')
  String? cityName;

  @JsonKey(name: 'gender')
  String? gender;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'nik')
  String? nik;

  @JsonKey(name: 'province_code')
  String? provinceCode;

  @JsonKey(name: 'province_name')
  String? provinceName;

  @JsonKey(name: 'rt')
  String? rt;

  @JsonKey(name: 'rw')
  String? rw;

  @JsonKey(name: 'subdistrict_code')
  String? subdistrictCode;

  @JsonKey(name: 'subdistrict_name')
  String? subdistrictName;

  @JsonKey(name: 'tps_no')
  String? tpsNo;

  @JsonKey(name: 'village_code')
  String? villageCode;

  @JsonKey(name: 'ward_code')
  String? wardCode;

  @JsonKey(name: 'ward_name')
  String? wardName;

  PotentialDpt({
    this.address,
    this.age,
    this.cityCode,
    this.cityName,
    this.gender,
    this.id,
    this.name,
    this.nik,
    this.provinceCode,
    this.provinceName,
    this.rt,
    this.rw,
    this.subdistrictCode,
    this.subdistrictName,
    this.tpsNo,
    this.villageCode,
    this.wardCode,
  });

  factory PotentialDpt.fromJson(Map<String, dynamic> json) =>
      _$PotentialDptFromJson(json);

  Map<String, dynamic> toJson() => _$PotentialDptToJson(this);
}
