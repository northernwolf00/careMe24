// class DangerModel {
//   final String incidentType;
//   final String dangerLevel;
//   final String country;
//   final String city;
//   final String comment;
//   final double centerLat;
//   final double centerLon;
//   final double radius;

//   DangerModel({
//     required this.incidentType,
//     required this.dangerLevel,
//     required this.country,
//     required this.city,
//     required this.comment,
//     required this.centerLat,
//     required this.centerLon,
//     required this.radius,
//   });

//   factory DangerModel.fromJson(Map<String, dynamic> json) {
//     return DangerModel(
//       incidentType: json['incident_type'] ?? '',
//       dangerLevel: json['danger_level'] ?? '',
//       country: json['country'] ?? '',
//       city: json['city'] ?? '',
//       comment: json['comment'] ?? '',
//       centerLat: (json['center_lat'] as num).toDouble(),
//       centerLon: (json['center_lon'] as num).toDouble(),
//       radius: json['radius'] ?? 0,
//     );
//   }
// }

class DangerModel {
  final String incidentType;
  final String dangerLevel;
  final String country;
  final String city;
  final String comment;
  final String type;
  final double centerLat;
  final double centerLon;
  final double radius;
  final bool isActive;

  DangerModel({
    required this.incidentType,
    required this.dangerLevel,
    required this.country,
    required this.city,
    required this.comment,
    required this.type,
    required this.centerLat,
    required this.centerLon,
    required this.radius,
    required this.isActive,
  });

  factory DangerModel.fromJson(Map<String, dynamic> json) {
    return DangerModel(
      incidentType: json['incident_type'] as String? ?? '',
      dangerLevel: json['danger_level'] as String? ?? '',
      country: json['country'] as String? ?? '',
      city: json['city'] as String? ?? '',
      comment: json['comment'] as String? ?? '',
      type: json['type'] as String? ?? '',
      centerLat: (json['center_lat'] as num?)?.toDouble() ?? 0.0,
      centerLon: (json['center_lon'] as num?)?.toDouble() ?? 0.0,
      radius: (json['radius'] as num?)?.toDouble() ?? 0.0,
      isActive: json['isActive'] as bool? ?? false,
    );
  }
}
