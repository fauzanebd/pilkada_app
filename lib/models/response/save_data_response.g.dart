// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveDataResponse _$SaveDataResponseFromJson(Map<String, dynamic> json) =>
    SaveDataResponse(
      id: (json['id'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$SaveDataResponseToJson(SaveDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
    };
