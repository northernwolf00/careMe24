class DangerModel {
  final String incidentType;
  final String dangerLevel;
  final String country;
  final String city;
  final String comment;
  final double centerLat;
  final double centerLon;
  final int radius;

  DangerModel({
    required this.incidentType,
    required this.dangerLevel,
    required this.country,
    required this.city,
    required this.comment,
    required this.centerLat,
    required this.centerLon,
    required this.radius,
  });

  factory DangerModel.fromJson(Map<String, dynamic> json) {
    return DangerModel(
      incidentType: json['incident_type'] ?? '',
      dangerLevel: json['danger_level'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      comment: json['comment'] ?? '',
      centerLat: (json['center_lat'] as num).toDouble(),
      centerLon: (json['center_lon'] as num).toDouble(),
      radius: json['radius'] ?? 0,
    );
  }
}
