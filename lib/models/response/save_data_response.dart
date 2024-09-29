import 'package:json_annotation/json_annotation.dart';

part 'save_data_response.g.dart';

@JsonSerializable()
class SaveDataResponse {
  int id;
  String message;

  SaveDataResponse({
    required this.id,
    required this.message,
  });

  factory SaveDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SaveDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SaveDataResponseToJson(this);
}
