// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ward _$WardFromJson(Map<String, dynamic> json) => Ward(
      code: json['code'] as String,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      subdistrictCode: json['subdistrict_code'] as String,
    );

Map<String, dynamic> _$WardToJson(Ward instance) => <String, dynamic>{
      'code': instance.code,
      'id': instance.id,
      'name': instance.name,
      'subdistrict_code': instance.subdistrictCode,
    };
