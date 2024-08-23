import 'package:get/get.dart';
import 'package:myapp/models/signup1.dart';
import 'package:myapp/models/signup2.dart';
import 'package:myapp/models/signup3.dart';

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

  // Method to get all data combined
  Map<String, dynamic> getAllData() {
    return {
      'sign_up': signUpData.value.toJson(),
      'farm_info': farmInfo.value.toJson(),
      'verification': verification.value.toJson(),
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
  }
}
