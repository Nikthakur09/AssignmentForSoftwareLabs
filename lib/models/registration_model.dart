import 'dart:convert';

class Farmer {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String businessName;
  final String informalName;
  final String address;
  final String city;
  final String state;
  final int zipCode;
  final String registrationProof;
  final Map<String, List<String>> businessHours;
  final String deviceToken;
  final String type;
  final String socialId;

  Farmer({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    required this.businessName,
    required this.informalName,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.registrationProof,
    required this.businessHours,
    required this.deviceToken,
    required this.type,
    required this.socialId,
  });

  // Factory constructor to create a Farmer instance from JSON
  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      role: json['role'],
      businessName: json['business_name'],
      informalName: json['informal_name'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zip_code'],
      registrationProof: json['registration_proof'],
      businessHours: Map<String, List<String>>.from(json['business_hours'].map((k, v) => MapEntry(k, List<String>.from(v)))),
      deviceToken: json['device_token'],
      type: json['type'],
      socialId: json['social_id'],
    );
  }

  // Method to convert a Farmer instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'business_name': businessName,
      'informal_name': informalName,
      'address': address,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'registration_proof': registrationProof,
      'business_hours': Map<String, List<String>>.from(businessHours.map((k, v) => MapEntry(k, List<String>.from(v)))),
      'device_token': deviceToken,
      'type': type,
      'social_id': socialId,
    };
  }

  // Method to create a Farmer instance from a JSON string
  static Farmer fromJsonString(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return Farmer.fromJson(jsonMap);
  }

  // Method to convert a Farmer instance to a JSON string
  String toJsonString() {
    final Map<String, dynamic> jsonMap = toJson();
    return jsonEncode(jsonMap);
  }
}
