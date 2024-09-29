// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visi_misi_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisiMisiResponse _$VisiMisiResponseFromJson(Map<String, dynamic> json) =>
    VisiMisiResponse(
      data: VisiMisi.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$VisiMisiResponseToJson(VisiMisiResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
      'message': instance.message,
    };
