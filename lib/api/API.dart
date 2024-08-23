import 'dart:convert';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/loginscreens/log_in_screen.dart';
import 'package:myapp/screens/loginscreens/otp_screen.dart';
import 'package:myapp/screens/loginscreens/reset_password_screen.dart';
import 'package:myapp/screens/signupscreens/signup_screen5.dart';
import 'package:myapp/models/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://sowlab.com/assignment/';

  Future<void> registerUser(SuperModel superModel) async {
    var uri = Uri.parse('$baseUrl/user/register');
    var request = http.Request('POST', uri)
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode(superModel.toJson())
      ..timeout = const Duration(seconds: 60);

    try {
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // Decode the response body
      final Map<String, dynamic> decodedResponse = jsonDecode(responseBody);
      print(decodedResponse);

      if (response.statusCode == 200) {
        bool success = decodedResponse['success'];
        String message = decodedResponse['message'];

        if (success) {
          // Success scenario
          Get.snackbar(
            'Success',
            message ?? 'Registration successful',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.to(() => SignUpScreen5()); // Navigate to HomeScreen on success
        } else {
          // Error scenario based on 'success' field
          Get.snackbar(
            'Error',
            message ?? 'Registration failed',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else if (response.statusCode == 401) {
        // Handling the "Email already exists" scenario
        String message = decodedResponse['message'] ?? 'Email  exists';
        Get.snackbar(
          'Error',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        // HTTP status code not handled
        Get.snackbar(
          'Error',
          'Failed to register: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Error during the HTTP request
      print('Error during registration: $e');
      Get.snackbar(
        'Error',
        'An error occurred during registration. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<String> loginUser({
    required String email,
    required String password,
    required String role,
    required String deviceToken,
    required String type,
    required String socialId,
  }) async {
    var uri = Uri.parse('$baseUrl/user/login');
    var requestBody = {
      'email': email,
      'password': password,
      'role': role,
      'device_token': deviceToken,
      'type': type,
      'social_id': socialId,
    };

    try {
      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('Response: ${response.body}');
      final responseBody = jsonDecode(response.body);

      bool success = responseBody['success'];
      String message = responseBody['message'];

      if (response.statusCode == 200) {
        if (success) {
          // Success scenario
          Get.snackbar(
            'Success',
            message ?? 'Login successful',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.to(() => const HomeScreen()); // Navigate to HomeScreen on success
          return response.body; // Return the response body on success
        } else {
          // Error scenario
          Get.snackbar(
            'Error',
            message ?? 'Login failed',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return 'Login failed: $message';
        }
      } else if (response.statusCode == 401) {
        // Unauthorized access scenario
        Get.snackbar(
          'Unauthorized',
          message ?? 'Invalid credentials',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return 'Unauthorized: $message';
      } else {
        // HTTP status code not handled
        Get.snackbar(
          'Error',
          'Failed to login: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return 'Failed to login: ${response.statusCode}';
      }
    } catch (e) {
      // Error during the HTTP request
      print('Error during login: $e');
      Get.snackbar(
        'Error',
        'An error occurred during login. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return 'Error during login: $e'; // Return an error message
    }
  }

  Future<void> forgotPassword({required String mobile}) async {
    var uri = Uri.parse('$baseUrl/user/forgot-password');
    var requestBody = {'mobile': mobile};

    try {
      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      final responseBody = jsonDecode(response.body);
      print(responseBody);
      bool success = responseBody['success'];
      String message = responseBody['message'];

      if (response.statusCode == 200 || response.statusCode == 401) {
        if (success) {
          // Success scenario
          Get.snackbar(
            'Success',
            message ?? 'Mobile Number verified successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          // Navigate to OTP screen
          Get.to(() => VerifyOTPScreen(phoneNumber: mobile));
        } else {
          // Error scenario
          Get.snackbar(
            'Error',
            message ?? 'Sorry, something went wrong.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          Get.to(() => VerifyOTPScreen(phoneNumber: mobile));
        }
      } else {
        // HTTP status code is not 200
        Get.snackbar(
          'Error',
          'Failed to send password reset link: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Get.to(() => LoginScreen());
      }
    } catch (e) {
      // Error during the HTTP request
      print('Error during password reset: $e');
      Get.snackbar(
        'Error',
        'An error occurred during password reset. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> verifyOtp({required String otp}) async {
    var uri = Uri.parse('$baseUrl/user/verify-otp');
    var requestBody = {'otp': otp};

    try {
      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      final responseBody = jsonDecode(response.body);

      bool success = responseBody['success'];
      String message = responseBody['message'];

      if (response.statusCode == 200 || response.statusCode == 401) {
        if (success) {
          // Success scenario
          Get.snackbar(
            'Success',
            message ?? 'OTP verified successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          // Navigate to ResetPasswordScreen
          Get.to(() => ResetPasswordScreen(
                otp: otp,
              ));
        } else {
          Get.snackbar(
            'Error',
            message ?? 'Sorry, something went wrong.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        // HTTP status code is not 200
        Get.snackbar(
          'Error',
          'Failed to verify OTP: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Get.back();
      }
    } catch (e) {
      print('Error during OTP verification: $e');
      Get.snackbar(
        'Error',
        'An error occurred during OTP verification. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> resetPassword({
    required String token,
    required String password,
    required String cpassword,
  }) async {
    var uri = Uri.parse('$baseUrl/user/reset-password');
    var requestBody = {
      'token': token,
      'password': password,
      'cpassword': cpassword,
    };

    try {
      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('Response: ${response.body}');
      final responseBody = jsonDecode(response.body);

      String success = responseBody['success'];
      String message = responseBody['message'];

      if (response.statusCode == 200) {
        if (success == 'true') {
          // Success scenario
          Get.snackbar(
            'Success',
            message ?? 'Your password has been successfully changed.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          // Navigate to LoginScreen
          Get.offAll(() => LoginScreen());
        } else {
          // Error scenario
          Get.snackbar(
            'Error',
            message ?? 'Sorry, something went wrong.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          Get.back(); // Optionally go back to the previous screen
        }
      } else {
        // HTTP status code is not 200
        Get.snackbar(
          'Error',
          'Failed to reset password: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Get.back(); // Optionally go back to the previous screen
      }
    } catch (e) {
      // Error during the HTTP request
      print('Error during password reset: $e');
      Get.snackbar(
        'Error',
        'An error occurred during password reset. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

extension on http.Request {
  set timeout(Duration timeout) {
    headers['timeout'] = timeout.inSeconds.toString();
  }
}
