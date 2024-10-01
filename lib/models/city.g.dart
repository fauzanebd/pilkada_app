// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) => City(
      code: json['code'] as String,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      provinceCode: json['province_code'] as String,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'code': instance.code,
      'id': instance.id,
      'name': instance.name,
      'province_code': instance.provinceCode,
    };
