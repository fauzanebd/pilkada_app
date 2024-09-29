class AppConfResponse {
  AppConfResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final int? status;
  final String? message;
  final AppConf? data;

  factory AppConfResponse.fromJson(Map<String, dynamic> json) {
    return AppConfResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : AppConf.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class AppConf {
  AppConf({
    this.sliderInterval = 4000,
  });

  final int sliderInterval;

  factory AppConf.fromJson(Map<String, dynamic> json) {
    return AppConf(
      sliderInterval: json["slider_interval"] == null
          ? 4000
          : json["slider_interval"] * 1000,
    );
  }

  Map<String, dynamic> toJson() => {
        "slider_interval": sliderInterval,
      };
}
