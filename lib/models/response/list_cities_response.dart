import 'package:json_annotation/json_annotation.dart';
import 'package:pilkada_app/models/city.dart';
import 'package:pilkada_app/models/response/meta.dart';

part 'list_cities_response.g.dart';

@JsonSerializable()
class ListCitiesResponse {
  List<City> data;
  bool error;
  String message;
  Meta meta;

  ListCitiesResponse({
    required this.data,
    required this.error,
    required this.message,
    required this.meta,
  });

  factory ListCitiesResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCitiesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListCitiesResponseToJson(this);
}
