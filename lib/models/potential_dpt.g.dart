// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'potential_dpt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PotentialDpt _$PotentialDptFromJson(Map<String, dynamic> json) => PotentialDpt(
      address: json['address'] as String?,
      age: (json['age'] as num?)?.toInt(),
      cityCode: json['city_code'] as String?,
      cityName: json['city_name'] as String?,
      gender: json['gender'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nik: json['nik'] as String?,
      provinceCode: json['province_code'] as String?,
      provinceName: json['province_name'] as String?,
      rt: json['rt'] as String?,
      rw: json['rw'] as String?,
      subdistrictCode: json['subdistrict_code'] as String?,
      subdistrictName: json['subdistrict_name'] as String?,
      tpsNo: json['tps_no'] as String?,
      villageCode: json['village_code'] as String?,
      wardCode: json['ward_code'] as String?,
    )..wardName = json['ward_name'] as String?;

Map<String, dynamic> _$PotentialDptToJson(PotentialDpt instance) =>
    <String, dynamic>{
      'address': instance.address,
      'age': instance.age,
      'city_code': instance.cityCode,
      'city_name': instance.cityName,
      'gender': instance.gender,
      'id': instance.id,
      'name': instance.name,
      'nik': instance.nik,
      'province_code': instance.provinceCode,
      'province_name': instance.provinceName,
      'rt': instance.rt,
      'rw': instance.rw,
      'subdistrict_code': instance.subdistrictCode,
      'subdistrict_name': instance.subdistrictName,
      'tps_no': instance.tpsNo,
      'village_code': instance.villageCode,
      'ward_code': instance.wardCode,
      'ward_name': instance.wardName,
    };
