// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subdistrict.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subdistrict _$SubdistrictFromJson(Map<String, dynamic> json) => Subdistrict(
      cityCode: json['city_code'] as String,
      code: json['code'] as String,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$SubdistrictToJson(Subdistrict instance) =>
    <String, dynamic>{
      'city_code': instance.cityCode,
      'code': instance.code,
      'id': instance.id,
      'name': instance.name,
    };
