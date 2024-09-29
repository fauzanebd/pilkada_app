// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadImageResponse _$UploadImageResponseFromJson(Map<String, dynamic> json) =>
    UploadImageResponse(
      data: DataPemilih.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UploadImageResponseToJson(
        UploadImageResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
      'message': instance.message,
    };
