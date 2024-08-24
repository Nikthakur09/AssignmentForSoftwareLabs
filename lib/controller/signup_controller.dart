import 'package:get/get.dart';
import 'package:myapp/models/signup1.dart';
import 'package:myapp/models/signup2.dart';
import 'package:myapp/models/signup3.dart';
import 'package:myapp/models/social.dart';

class SignUpController extends GetxController {
  // Observables to store the state
  var signUpData = SignUp(
    fullName: '',
    email: '',
    phone: '',
    password: '',
  ).obs;

  var farmInfo = FarmInfo(
    businessName: '',
    informalName: '',
    streetAddress: '',
    city: '',
    state: '',
    zipCode: 0,
  ).obs;

  var verification = Verification().obs;
  
  var socialLoginInfo = SocialLoginInfo(
    type: '',
    socialId: '',
    deviceToken: '',
  ).obs;

  // Method to update SignUp data
  void updateSignUpData({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) {
    signUpData.update((val) {
      val?.fullName = fullName;
      val?.email = email;
      val?.phone = phone;
      val?.password = password;
    });
  }

  // Method to update FarmInfo data
  void updateFarmInfo({
    required String businessName,
    required String informalName,
    required String streetAddress,
    required String city,
    required String state,
    required int zipCode,
  }) {
    farmInfo.update((val) {
      if (val != null) {
        val.businessName = businessName;
        val.informalName = informalName;
        val.streetAddress = streetAddress;
        val.city = city;
        val.state = state;
        val.zipCode = zipCode;
      }
    });
  }

  // Method to update Verification data
  void updateVerification(String? fileName) {
    verification.update((val) {
      val?.fileName = fileName;
    });
  }
  
  // Method to update SocialLoginInfo data
  void updateSocialLoginInfo({
    required String loginType,
    required String socialId,
    required String deviceToken,
  }) {
    socialLoginInfo.update((val) {
      val?.type = loginType;
      val?.socialId = socialId;
      val?.deviceToken = deviceToken;
    });
  }

  // Method to get all data combined
  Map<String, dynamic> getAllData() {
    return {
      'sign_up': signUpData.value.toJson(),
      'farm_info': farmInfo.value.toJson(),
      'verification': verification.value.toJson(),
      'social_login_info': socialLoginInfo.value.toJson(),
    };
  }

  // Method to clear all data
  void clearAllData() {
    signUpData.value = SignUp(
      fullName: '',
      email: '',
      phone: '',
      password: '',
    );

    farmInfo.value = FarmInfo(
      businessName: '',
      informalName: '',
      streetAddress: '',
      city: '',
      state: '',
      zipCode: 0,
    );

    verification.value = Verification();

    socialLoginInfo.value = SocialLoginInfo(
      type: '',
      socialId: '',
      deviceToken: '',
    );
  }
}
