import 'package:json_annotation/json_annotation.dart';
import 'package:pilkada_app/models/data_pemilih.dart';

part 'upload_image_response.g.dart';

@JsonSerializable()
class UploadImageResponse {
  DataPemilih data;
  bool error;
  String message;

  UploadImageResponse({
    required this.data,
    required this.error,
    required this.message,
  });

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageResponseToJson(this);
}
