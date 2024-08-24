import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/api/API.dart';
import 'package:myapp/screens/loginscreens/forget_password_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/signupscreens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ApiService apiService = ApiService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _login() async {
    setState(() {
      _errorMessage = '';
    });
  }

  void _navigateSignUp() {
    Get.to(() => SignUpScreen1());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100),
                Text(
                  'Welcome back!',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 70),
                Row(
                  children: [
                    Text(
                      'New here? ',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: _navigateSignUp,
                      child: Text(
                        'Create account',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  style: GoogleFonts.poppins(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: GoogleFonts.poppins(color: Colors.black54),
                    prefixIcon: const Icon(Icons.email, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300]!, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[400]!, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  style: GoogleFonts.poppins(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: GoogleFonts.poppins(color: Colors.black54),
                    prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(ForgotPasswordScreen());
                          },
                          child: Text(
                            'Forgot?',
                            style: GoogleFonts.poppins(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300]!, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[400]!, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: GoogleFonts.poppins(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _login,
                  // ignore: sort_child_properties_last
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text('Login',
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE9725A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'or login with',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.google,
                          color: Colors.red),
                      onPressed: apiService.signInWithGoogle,
                      iconSize: 40,
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.apple,
                          color: Colors.black),
                      onPressed: () {
                        apiService.signInWithApple();
                      },
                      iconSize: 40,
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.facebook,
                          color: Colors.blue),
                      onPressed: () {
                        apiService.signInWithFacebook(context);
                      },
                      iconSize: 40,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
