class ServiceModel {
  final String id;
  final String type;
  final bool verified;
  final num price;
  final String name;
  final String specialization;
  final num experience;
  final List<String> diplomas;
  final List<String> reviews;
  final String workPlace;
  final bool goHome;
  final String institutionName;
  final bool institutionCommercial;
  final String institutionType;
  final String institutionAge;
  final String license;
  final String photo;
  final List<String> calls;
  final List<String> appointments;
  final List<String> statements;

  ServiceModel({
    required this.id,
    required this.type,
    required this.verified,
    required this.price,
    required this.name,
    required this.specialization,
    required this.experience,
    required this.diplomas,
    required this.reviews,
    required this.workPlace,
    required this.goHome,
    required this.institutionName,
    required this.institutionCommercial,
    required this.institutionType,
    required this.institutionAge,
    required this.license,
    required this.photo,
    required this.calls,
    required this.appointments,
    required this.statements,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? '',  
      type: json['type'] ?? '', 
      verified: json['verified'] ?? false,  
      price: json['price'] ?? 0,  
      name: json['name'] ?? '', 
      specialization: json['specialization'] ?? '', 
      experience: json['experience'] ?? 0,  
      diplomas: (json['diplomas'] as List<dynamic>?)?.map((item) => item as String).toList() ?? [],
      reviews: (json['reviews'] as List<dynamic>?)?.map((item) => item as String).toList() ?? [],
      workPlace: json['work_place'] ?? '',
      goHome: json['go_home'] ?? false,  
      institutionName: json['institution_name'] ?? '',
      institutionCommercial: json['institution_commercial'] ?? false, 
      license: json['license'] ?? '',
      institutionType: json['institution_type'] ?? '',  
      institutionAge: json['institution_age'] ?? '',  
      photo: json['photo'] ?? '', 
      calls: (json['calls'] as List<dynamic>?)?.map((item) {
        if (item is String) {
          return item;
        } else if (item is Map) {
          return item.toString();  
        }
        return '';  
      }).toList() ?? [],
      
      appointments: (json['appointments'] as List<dynamic>?)?.map((item) {
        if (item is String) {
          return item;
        } else if (item is Map) {
          return item.toString();
        }
        return ''; 
      }).toList() ?? [],
      
      statements: (json['statements'] as List<dynamic>?)?.map((item) {
        if (item is String) {
          return item;
        } else if (item is Map) {
          return item.toString();
        }
        return ''; 
      }).toList() ?? [],
    );
  } 
}

