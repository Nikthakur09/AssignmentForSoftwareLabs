import 'package:myapp/models/signup1.dart';
import 'package:myapp/models/signup2.dart';
import 'package:myapp/models/signup3.dart';
import 'package:myapp/models/signup4.dart';
import 'package:myapp/models/social.dart';

class SuperModel {
  final SignUp signUp;
  final FarmInfo farmInfo;
  final Verification verification;
  final BusinessHours businessHours;

  final SocialLoginInfo socialLoginInfo;


  SuperModel({
    required this.signUp,
    required this.farmInfo,
    required this.verification,
    required this.businessHours,
    required this.socialLoginInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': signUp.fullName,
      'email': signUp.email,
      'phone': signUp.phone,
      'password': signUp.password,
      'role': "farmer",
      'business_name': farmInfo.businessName,
      'informal_name': farmInfo.informalName,
      'address': farmInfo.streetAddress,
      'city': farmInfo.city,
      'state': farmInfo.state,
      'zip_code': farmInfo.zipCode,
      'registration_proof': verification.fileName,
      'business_hours': businessHours.toJson(),
      'device_token': socialLoginInfo.deviceToken,
      'type': socialLoginInfo.type,
      'social_id': socialLoginInfo.socialId,
    };
  }
}
