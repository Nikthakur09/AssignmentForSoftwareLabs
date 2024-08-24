class SocialLoginInfo {
   String deviceToken;
   String type; // email/facebook/google/apple
   String socialId;

  SocialLoginInfo({
    required this.deviceToken,
    required this.type,
    required this.socialId,
  });

  // Factory constructor to create an instance from JSON
  factory SocialLoginInfo.fromJson(Map<String, dynamic> json) {
    return SocialLoginInfo(
      deviceToken: json['device_token'],
      type: json['type'],
      socialId: json['social_id'],
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'device_token': deviceToken,
      'type': type,
      'social_id': socialId,
    };
  }
}
