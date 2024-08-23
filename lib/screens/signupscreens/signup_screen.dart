import 'package:myapp/screens/loginscreens/log_in_screen.dart';
import 'package:myapp/screens/signupscreens/signup_screen2.dart';
import 'package:myapp/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen1 extends StatelessWidget {
  final SignUpController _controller = Get.put(SignUpController());

  SignUpScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'FarmerEats',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome!',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            Text(
              'Signup 1 of 4',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 70,
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: IconButton(
                    icon:
                        const Icon(FontAwesomeIcons.google, color: Colors.red),
                    onPressed: () {
                      // Google login logic
                    },
                    iconSize: 40,
                  ),
                ),
                Container(
                  height: 70,
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: IconButton(
                    icon:
                        const Icon(FontAwesomeIcons.apple, color: Colors.black),
                    onPressed: () {
                      // Apple login logic
                    },
                    iconSize: 40,
                  ),
                ),
                Container(
                  height: 70,
                  width: 100,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.facebook,
                        color: Colors.blue),
                    onPressed: () {
                      // Facebook login logic
                    },
                    iconSize: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            TextField(
              onChanged: (value) => _controller.updateSignUpData(
                fullName: value,
                email: _controller.signUpData.value.email,
                phone: _controller.signUpData.value.phone,
                password: _controller.signUpData.value.password,
              ),
              decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: GoogleFonts.poppins(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: const Icon(Icons.person, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => _controller.updateSignUpData(
                fullName: _controller.signUpData.value.fullName,
                email: value,
                phone: _controller.signUpData.value.phone,
                password: _controller.signUpData.value.password,
              ),
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: GoogleFonts.poppins(color: Colors.black54),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    '@',
                    style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => _controller.updateSignUpData(
                fullName: _controller.signUpData.value.fullName,
                email: _controller.signUpData.value.email,
                phone: value,
                password: _controller.signUpData.value.password,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Phone Number',
                labelStyle: GoogleFonts.poppins(color: Colors.black54),
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: const Icon(Icons.phone, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => _controller.updateSignUpData(
                fullName: _controller.signUpData.value.fullName,
                email: _controller.signUpData.value.email,
                phone: _controller.signUpData.value.phone,
                password: value,
              ),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: GoogleFonts.poppins(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: const Icon(Icons.lock_outline_rounded,
                    color: Colors.black54),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => _controller.updateSignUpData(
                fullName: _controller.signUpData.value.fullName,
                email: _controller.signUpData.value.email,
                phone: _controller.signUpData.value.phone,
                password: _controller.signUpData.value.password,
              ),
              decoration: InputDecoration(
                labelText: 'Re-enter Password',
                labelStyle: GoogleFonts.poppins(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: const Icon(Icons.lock_outline_rounded,
                    color: Colors.black54),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () => Get.to(() => LoginScreen()),
            ),
            ElevatedButton(
              onPressed: () => Get.to(() => SignUpScreen2()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE9725A),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
