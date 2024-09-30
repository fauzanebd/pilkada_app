import 'package:json_annotation/json_annotation.dart';
import 'package:pilkada_app/models/data_pemilih.dart';

part 'update_data_response.g.dart';

@JsonSerializable()
class UpdateDataResponse {
  DataPemilih data;
  bool error;
  String message;

  UpdateDataResponse({
    required this.data,
    required this.error,
    required this.message,
  });

  factory UpdateDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDataResponseToJson(this);
}
