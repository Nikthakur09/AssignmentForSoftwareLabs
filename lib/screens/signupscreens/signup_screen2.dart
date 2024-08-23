import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/signupscreens/signup_screen3.dart';
import 'package:myapp/controller/signup_controller.dart';
import 'package:myapp/models/signup2.dart';

class SignUpScreen2 extends StatefulWidget {
  const SignUpScreen2({super.key});

  @override
  _SignUpScreen2State createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _informalNameController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  // Get the SignUpController instance
  final SignUpController _signUpController = Get.find<SignUpController>();

  String? _selectedState;

  final List<String> _indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  @override
  void dispose() {
    _businessNameController.dispose();
    _informalNameController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final farmInfo = FarmInfo(
      businessName: _businessNameController.text,
      informalName: _informalNameController.text,
      streetAddress: _streetAddressController.text,
      city: _cityController.text,
      state: _selectedState ?? '',
      zipCode: int.tryParse(_zipCodeController.text) ?? 0,
    );

    _signUpController.updateFarmInfo(
      businessName: farmInfo.businessName,
      informalName: farmInfo.informalName,
      streetAddress: farmInfo.streetAddress,
      city: farmInfo.city,
      state: farmInfo.state,
      zipCode: farmInfo.zipCode,
    );

    Get.to(() => const SignUpScreen3());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'FarmerEats',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Signup 2 of 4',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 30),
            Text(
              'Farm Info',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 35),
            TextField(
              controller: _businessNameController,
              decoration: InputDecoration(
                labelText: 'Business Name',
                labelStyle: GoogleFonts.poppins(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                prefixIcon: const Icon(Icons.business, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _informalNameController,
              decoration: InputDecoration(
                labelText: 'Informal Name',
                labelStyle: GoogleFonts.poppins(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                prefixIcon: const Icon(Icons.tag_faces, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _streetAddressController,
              decoration: InputDecoration(
                labelText: 'Street Address',
                labelStyle: GoogleFonts.poppins(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                prefixIcon: const Icon(Icons.home, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City',
                labelStyle: GoogleFonts.poppins(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                prefixIcon: const Icon(Icons.location_city, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: DropdownButtonFormField<String>(
                    value: _selectedState,
                    decoration: InputDecoration(
                      labelText: 'State',
                      labelStyle: GoogleFonts.poppins(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      prefixIcon: const Icon(Icons.location_on_outlined,
                          color: Colors.black54),
                    ),
                    items: _indianStates
                        .map((state) => DropdownMenuItem<String>(
                              value: state,
                              child: SizedBox(
                                width: 90,
                                child: Text(
                                  state,
                                  style: GoogleFonts.poppins(),
                                  overflow: TextOverflow.clip, // Truncate with ellipsis
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedState = newValue;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8), // Adjust the width as needed
                Flexible(
                  child: TextField(
                    controller: _zipCodeController,
                    decoration: InputDecoration(
                      labelText: 'Enter Zipcode',
                      labelStyle: GoogleFonts.poppins(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      prefixIcon: const Icon(Icons.pin_drop, color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: const Icon(Icons.arrow_back),
                  onTap: () => Get.back(),
                ),
                ElevatedButton(
                  onPressed: _handleContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE9725A),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Continue',
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
