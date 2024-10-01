import 'package:json_annotation/json_annotation.dart';

part 'delete_data_response.g.dart';

@JsonSerializable()
class DeleteDataResponse {
  String message;

  DeleteDataResponse({
    required this.message,
  });

  factory DeleteDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteDataResponseToJson(this);
}
