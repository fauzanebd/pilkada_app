// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_anggota_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAnggotaResponse _$ListAnggotaResponseFromJson(Map<String, dynamic> json) =>
    ListAnggotaResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Anggota.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as bool,
      message: json['message'] as String,
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListAnggotaResponseToJson(
        ListAnggotaResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
      'message': instance.message,
      'meta': instance.meta,
    };
