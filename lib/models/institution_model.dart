class InstitutionModel {
  final String id;
  final String name;
  final bool commercial;
  final String type;
  final String address;
  final Location location;

  InstitutionModel({
    required this.id,
    required this.name,
    required this.commercial,
    required this.type,
    required this.address,
    required this.location,
  });

  factory InstitutionModel.fromJson(Map<String, dynamic> json) {
    return InstitutionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      commercial: json['commercial'] ?? false,
      type: json['type'] ?? '',
      address: json['address'] ?? '',
      location: Location.fromJson(json['location']),
    );
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: List<double>.from(json['coordinates'] ?? []),
    );
  }
}
