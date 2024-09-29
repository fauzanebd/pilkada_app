// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Locations _$LocationsFromJson(Map<String, dynamic> json) => Locations(
      city: json['city'] as String?,
      province: json['province'] as String?,
      subdistrict: json['subdistrict'] as String?,
      ward: json['ward'] as String?,
    );

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'city': instance.city,
      'province': instance.province,
      'subdistrict': instance.subdistrict,
      'ward': instance.ward,
    };
