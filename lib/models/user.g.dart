// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      avatar: json['avatar'] as String?,
      cityCode: json['city_code'] as String?,
      clientCode: json['client_code'] as String?,
      createdAt: json['created_at'] as String?,
      hierarchy: json['hierarchy'] as String?,
      hierarchyValue: (json['hierarchy_value'] as num?)?.toInt(),
      id: (json['id'] as num).toInt(),
      isEnumerator: json['is_enumerator'] as bool?,
      locations: json['locations'] == null
          ? null
          : Locations.fromJson(json['locations'] as Map<String, dynamic>),
      name: json['name'] as String?,
      nasional: json['nasional'] as bool?,
      noPhone: json['no_phone'] as String?,
      provinceCode: json['province_code'] as String?,
      role: json['role'] as String?,
      subdistrictCode: json['subdistrict_code'] as String?,
      updatedAt: json['updated_at'] as String?,
      username: json['username'] as String?,
      villageCode: json['village_code'] as String?,
      wardCode: json['ward_code'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'avatar': instance.avatar,
      'city_code': instance.cityCode,
      'client_code': instance.clientCode,
      'created_at': instance.createdAt,
      'hierarchy': instance.hierarchy,
      'hierarchy_value': instance.hierarchyValue,
      'id': instance.id,
      'is_enumerator': instance.isEnumerator,
      'locations': instance.locations,
      'name': instance.name,
      'nasional': instance.nasional,
      'no_phone': instance.noPhone,
      'province_code': instance.provinceCode,
      'role': instance.role,
      'subdistrict_code': instance.subdistrictCode,
      'updated_at': instance.updatedAt,
      'username': instance.username,
      'village_code': instance.villageCode,
      'ward_code': instance.wardCode,
    };
