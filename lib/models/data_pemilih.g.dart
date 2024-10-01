// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_pemilih.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPemilih _$DataPemilihFromJson(Map<String, dynamic> json) => DataPemilih(
      address: json['address'] as String?,
      birthDate: json['birth_date'] as String?,
      category: json['category'] as String?,
      cityCode: json['city_code'] as String?,
      cityName: json['city_name'] as String?,
      clientCode: json['client_code'] as String?,
      confirmationStatus: json['confirmation_status'] as String?,
      expectationToCandidate: json['expectation_to_candidate'] as String?,
      gender: json['gender'] as String?,
      isPartyMember: json['is_party_member'] as bool?,
      modelId: (json['model_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nik: json['nik'] as String?,
      noPhone: json['no_phone'] as String?,
      noTps: json['no_tps'] as String?,
      positioningToCandidate: json['positioning_to_candidate'] as String?,
      provinceCode: json['province_code'] as String?,
      provinceName: json['province_name'] as String?,
      relationToCandidate: json['relation_to_candidate'] as String?,
      s3File: json['s3_file'] as String?,
      subdistrictCode: json['subdistrict_code'] as String?,
      subdistrictName: json['subdistrict_name'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      villageCode: json['village_code'] as String?,
      wardCode: json['ward_code'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    )
      ..id = (json['id'] as num?)?.toInt()
      ..villageName = json['village_name'] as String?
      ..wardName = json['ward_name'] as String?;

Map<String, dynamic> _$DataPemilihToJson(DataPemilih instance) =>
    <String, dynamic>{
      'address': instance.address,
      'birth_date': instance.birthDate,
      'category': instance.category,
      'city_code': instance.cityCode,
      'city_name': instance.cityName,
      'client_code': instance.clientCode,
      'confirmation_status': instance.confirmationStatus,
      'expectation_to_candidate': instance.expectationToCandidate,
      'gender': instance.gender,
      'is_party_member': instance.isPartyMember,
      'model_id': instance.modelId,
      'name': instance.name,
      'nik': instance.nik,
      'no_phone': instance.noPhone,
      'no_tps': instance.noTps,
      'positioning_to_candidate': instance.positioningToCandidate,
      'province_code': instance.provinceCode,
      'province_name': instance.provinceName,
      'relation_to_candidate': instance.relationToCandidate,
      's3_file': instance.s3File,
      'subdistrict_code': instance.subdistrictCode,
      'subdistrict_name': instance.subdistrictName,
      'user_id': instance.userId,
      'id': instance.id,
      'village_code': instance.villageCode,
      'village_name': instance.villageName,
      'ward_code': instance.wardCode,
      'ward_name': instance.wardName,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
