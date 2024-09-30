import 'package:json_annotation/json_annotation.dart';

part 'anggota.g.dart';

@JsonSerializable()
class Anggota {
  @JsonKey(name: 'avatar')
  String? avatar;

  @JsonKey(name: 'city_code')
  String? cityCode;

  @JsonKey(name: 'client_code')
  String? clientCode;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'hierarchy')
  String hierarchy;

  @JsonKey(name: 'hierarchy_value')
  int hierarchyValue;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'is_enumerator')
  bool isEnumerator;

  @JsonKey(name: 'locations')
  String? locations;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'nasional')
  bool nasional;

  @JsonKey(name: 'no_phone')
  String? noPhone;

  @JsonKey(name: 'province_code')
  String? provinceCode;

  @JsonKey(name: 'role')
  String role;

  @JsonKey(name: 'subdistrict_code')
  String? subdistrictCode;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'village_code')
  String? villageCode;

  @JsonKey(name: 'ward_code')
  String? wardCode;

  Anggota({
    this.avatar,
    this.cityCode,
    this.clientCode,
    this.createdAt,
    required this.hierarchy,
    required this.hierarchyValue,
    required this.id,
    required this.isEnumerator,
    this.locations,
    required this.name,
    required this.nasional,
    this.noPhone,
    this.provinceCode,
    required this.role,
    this.subdistrictCode,
    this.updatedAt,
    required this.username,
    this.villageCode,
    this.wardCode,
  });

  factory Anggota.fromJson(Map<String, dynamic> json) =>
      _$AnggotaFromJson(json);

  Map<String, dynamic> toJson() => _$AnggotaToJson(this);
}
