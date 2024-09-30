// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateDataResponse _$UpdateDataResponseFromJson(Map<String, dynamic> json) =>
    UpdateDataResponse(
      data: DataPemilih.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UpdateDataResponseToJson(UpdateDataResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
      'message': instance.message,
    };
