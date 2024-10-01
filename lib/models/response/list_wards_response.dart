import 'package:json_annotation/json_annotation.dart';
import 'package:pilkada_app/models/ward.dart';

import 'meta.dart';

part 'list_wards_response.g.dart';

@JsonSerializable()
class ListWardsResponse {
  List<Ward> data;
  bool error;
  String message;
  Meta meta;

  ListWardsResponse({
    required this.data,
    required this.error,
    required this.message,
    required this.meta,
  });

  factory ListWardsResponse.fromJson(Map<String, dynamic> json) =>
      _$ListWardsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListWardsResponseToJson(this);
}
