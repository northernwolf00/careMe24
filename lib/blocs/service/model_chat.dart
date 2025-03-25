import 'dart:convert';

// Define the Service model
class Service {
  String login;
  String password;
  String type;
  String name;
  String specialization;
  int experience;
  double price;
  List<String> diplomas;
  List<String> reviews;
  String workPlace;
  bool goHome;
  String institutionName;
  bool institutionCommercial;
  String institutionType;
  String institutionAge;
  String license;
  String photo;
  bool verified;
  String otp;
  String id;

  Service({
    required this.login,
    required this.password,
    required this.type,
    required this.name,
    required this.specialization,
    required this.experience,
    required this.price,
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
    required this.verified,
    required this.otp,
    required this.id,
  });

  // Factory method to create a Service from JSON
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      login: json['login'],
      password: json['password'],
      type: json['type'],
      name: json['name'],
      specialization: json['specialization'],
      experience: json['experience'],
      price: json['price'].toDouble(),
      diplomas: List<String>.from(json['diplomas']),
      reviews: List<String>.from(json['reviews']),
      workPlace: json['work_place'],
      goHome: json['go_home'],
      institutionName: json['institution_name'],
      institutionCommercial: json['institution_commercial'],
      institutionType: json['institution_type'],
      institutionAge: json['institution_age'],
      license: json['license'],
      photo: json['photo'],
      verified: json['verified'],
      otp: json['otp'],
      id: json['id'],
    );
  }

  // Convert Service to JSON
  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
      'type': type,
      'name': name,
      'specialization': specialization,
      'experience': experience,
      'price': price,
      'diplomas': diplomas,
      'reviews': reviews,
      'work_place': workPlace,
      'go_home': goHome,
      'institution_name': institutionName,
      'institution_commercial': institutionCommercial,
      'institution_type': institutionType,
      'institution_age': institutionAge,
      'license': license,
      'photo': photo,
      'verified': verified,
      'otp': otp,
      'id': id,
    };
  }
}

// Define the main model for the entire response
class ServiceResponse {
  String serviceId;
  String userId;
  List<Message> messages;
  Service service;
  int countOfUnreadMessages;
  String id;

  ServiceResponse({
    required this.serviceId,
    required this.userId,
    required this.messages,
    required this.service,
    required this.countOfUnreadMessages,
    required this.id,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return ServiceResponse(
      serviceId: json['service_id'],
      userId: json['user_id'],
      messages: (json['messages'] as List).map((msg) => Message.fromJson(msg)).toList(),
      service: Service.fromJson(json['service']),
      countOfUnreadMessages: json['count_of_unread_messages'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'user_id': userId,
      'messages': messages.map((msg) => msg.toJson()).toList(),
      'service': service.toJson(),
      'count_of_unread_messages': countOfUnreadMessages,
      'id': id,
    };
  }
}

class Message {
  String id;
  String from;
  String text;
  String type;
  String? file;
  bool readByService;
  bool readByUser;
  DateTime createdAt;

  Message({
    required this.id,
    required this.from,
    required this.text,
    required this.type,
    this.file,
    required this.readByService,
    required this.readByUser,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      from: json['from'],
      text: json['text'],
      type: json['type'],
      file: json['file'],
      readByService: json['read_by_service'],
      readByUser: json['read_by_user'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'from': from,
      'text': text,
      'type': type,
      'file': file,
      'read_by_service': readByService,
      'read_by_user': readByUser,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

