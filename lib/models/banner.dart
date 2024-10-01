class CarouselItem {
  CarouselItem({
    required this.bannerId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    this.isPng = false,
  });

  final int? bannerId;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isPng;

  factory CarouselItem.fromJson(Map<String, dynamic> json) {
    return CarouselItem(
      bannerId: json["banner_id"],
      image: json["image"],
      createdAt: DateTime.tryParse(json["created_at"] ?? "")?.toLocal(),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? "")?.toLocal(),
    );
  }

  Map<String, dynamic> toJson() => {
        "banner_id": bannerId,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
