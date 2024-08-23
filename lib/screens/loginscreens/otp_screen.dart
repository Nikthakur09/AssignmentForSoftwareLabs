import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/api/API.dart';
import 'package:myapp/screens/loginscreens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/loginscreens/log_in_screen.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class VerifyOTPScreen extends StatefulWidget {
  final String phoneNumber; // Phone number passed from ForgotPasswordScreen

  const VerifyOTPScreen({super.key, required this.phoneNumber});

  @override
  _VerifyOTPScreenState createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final ApiService _apiService = ApiService();
  String _otp = '';

  void _verifyOtp() async {
    if (_otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the OTP.'),
        ),
      );
      return;
    }

    try {
      await _apiService.verifyOtp(otp: _otp);
      Get.to(() =>
          ResetPasswordScreen(otp: _otp)); // Navigate to reset password screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _resendCode() async {
    final mobileNumber = widget.phoneNumber;
    try {
      await _apiService.forgotPassword(mobile: mobileNumber);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP resent successfully.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'FarmerEats',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width / 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 10),
              const Text(
                'Verify OTP',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height / 40),
              GestureDetector(
                onTap: () {
                  Get.to(() => LoginScreen());
                },
                child: const Text.rich(
                  TextSpan(
                    text: 'Remember your password?  ',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style:
                            TextStyle(color: Color(0xFFD5715B), fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height / 14),
              OTPTextField(
                length: 6,
                width: width,
                fieldWidth: 50,
                style: const TextStyle(fontSize: 20),
                textFieldAlignment: MainAxisAlignment.spaceEvenly,
                fieldStyle: FieldStyle.box,
                otpFieldStyle: OtpFieldStyle(
                  backgroundColor: Colors.grey[200]!,
                  borderColor: Colors.transparent,
                ),
                onCompleted: (pin) {
                  setState(() {
                    _otp = pin;
                  });
                },
              ),
              SizedBox(height: height / 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: const Color(0xFFD5715B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: _verifyOtp,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height / 30),
              Center(
                child: GestureDetector(
                  onTap: _resendCode,
                  child: const Text(
                    'Resend Code',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
