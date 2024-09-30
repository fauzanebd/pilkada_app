// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daftar_data_pemilih_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DaftarDataPemilihResponse _$DaftarDataPemilihResponseFromJson(
        Map<String, dynamic> json) =>
    DaftarDataPemilihResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => DataPemilih.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as bool,
      message: json['message'] as String,
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DaftarDataPemilihResponseToJson(
        DaftarDataPemilihResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
      'message': instance.message,
      'meta': instance.meta,
    };
