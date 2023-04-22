class RocketResponseModel {
  final String name;
  final String country;
  final EnginesItemModel engines;
  final List<String> flickrImages;
  final bool active;
  final int costPerLaunch;
  final int successRatePct;
  final String wikipedia;
  final String description;
  final String id;
  final DiameterItemModel height;
  final DiameterItemModel diameter;

  RocketResponseModel({
    required this.name,
    required this.country,
    required this.engines,
    required this.flickrImages,
    required this.active,
    required this.costPerLaunch,
    required this.successRatePct,
    required this.wikipedia,
    required this.description,
    required this.id,
    required this.height,
    required this.diameter,
  });

  factory RocketResponseModel.fromJson(Map<String, dynamic> json) {
    RocketResponseModel rocketItemModel = RocketResponseModel(
      name: json["name"],
      country: json["country"],
      engines: EnginesItemModel.fromJson(json["engines"]),
      flickrImages: List<String>.from(json["flickr_images"].map((x) => x)),
      active: json["active"],
      costPerLaunch: json["cost_per_launch"],
      successRatePct: json["success_rate_pct"],
      wikipedia: json["wikipedia"],
      description: json["description"],
      id: json["id"],
      height: DiameterItemModel.fromJson(json["height"]),
      diameter: DiameterItemModel.fromJson(json["diameter"]),
    );
    return rocketItemModel;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "engines": engines,
        "flickr_images": List<dynamic>.from(flickrImages.map((x) => x)),
        "active": active,
        "cost_per_launch": costPerLaunch,
        "success_rate_pct": successRatePct,
        "wikipedia": wikipedia,
        "description": description,
        "id": id,
        "height": height,
        "diameter": diameter,
      };
}

class EnginesItemModel {
  final int number;

  EnginesItemModel({required this.number});

  factory EnginesItemModel.fromJson(Map<String, dynamic> json) {
    EnginesItemModel enginesItemModel = EnginesItemModel(
      number: json["number"],
    );
    return enginesItemModel;
  }

  Map<String, dynamic> toJson() => {
        "number": number,
      };
}

class DiameterItemModel {
  final double meters;
  final double feet;

  DiameterItemModel({
    required this.meters,
    required this.feet,
  });

  factory DiameterItemModel.fromJson(Map<String, dynamic> json) {
    DiameterItemModel diameterItemModel = DiameterItemModel(
      meters: json["meters"].toDouble(),
      feet: json["feet"].toDouble(),
    );
    return diameterItemModel;
  }

  Map<String, dynamic> toJson() => {
        "meters": meters,
        "feet": feet,
      };
}

class ImageModel {
  String id;
  String rocketId;
  String flickerImage;

  ImageModel(
      {required this.id, required this.rocketId, required this.flickerImage});
}
