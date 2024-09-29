import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'locations.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'avatar')
  String? avatar;

  @JsonKey(name: 'city_code')
  String? cityCode;

  @JsonKey(name: 'client_code')
  String? clientCode;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'hierarchy')
  String? hierarchy;

  @JsonKey(name: 'hierarchy_value')
  int? hierarchyValue;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'is_enumerator')
  bool? isEnumerator;

  @JsonKey(name: 'locations')
  Locations? locations;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'nasional')
  bool? nasional;

  @JsonKey(name: 'no_phone')
  String? noPhone;

  @JsonKey(name: 'province_code')
  String? provinceCode;

  @JsonKey(name: 'role')
  String? role;

  @JsonKey(name: 'subdistrict_code')
  String? subdistrictCode;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'username')
  String? username;

  @JsonKey(name: 'village_code')
  String? villageCode;

  @JsonKey(name: 'ward_code')
  String? wardCode;

  User({
    this.avatar,
    this.cityCode,
    this.clientCode,
    this.createdAt,
    this.hierarchy,
    this.hierarchyValue,
    required this.id,
    this.isEnumerator,
    this.locations,
    this.name,
    this.nasional,
    this.noPhone,
    this.provinceCode,
    this.role,
    this.subdistrictCode,
    this.updatedAt,
    this.username,
    this.villageCode,
    this.wardCode,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String jsonToString() {
    return jsonEncode(this);
  }

  static User fromString(String jsonString) {
    return User.fromJson(jsonDecode(jsonString));
  }
}
