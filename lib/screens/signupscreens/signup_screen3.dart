import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:myapp/controller/signup_controller.dart';
import 'package:myapp/screens/signupscreens/signup_screen4.dart';

class SignUpScreen3 extends StatefulWidget {
  const SignUpScreen3({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreen3State createState() => _SignUpScreen3State();
}

class _SignUpScreen3State extends State<SignUpScreen3> {
  String? _fileName;
  String? _error;
  final SignUpController controller = Get.find();

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        setState(() {
          _fileName = result.files.single.name;
          _error = null;
        });
      } else {
        setState(() {
          _fileName = null;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error picking file: $e';
      });
    }
  }

  void _handleContinue() {
    if (_fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please attach proof of registration.')),
      );
      return;
    }

    controller.updateVerification(_fileName!);
    Get.to(() => const SignUpScreen4());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'FarmerEats',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verification',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Signup 3 of 4',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 50),
            const Text(
              'Attach proof of Department of Agriculture registration (e.g., Fokko Fresh, USDA Approved, USDA Organic)',
              style: TextStyle(color: Colors.black54, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text(
                  'Attach proof of Registration',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(width: 70),
                IconButton(
                  icon: Image.asset(
                    'assets/images/icon.png',
                    height: 50,
                  ),
                  onPressed: _pickFile,
                )
              ],
            ),
            if (_fileName != null) ...[
              const SizedBox(height: 10),
              Text(
                'Selected file: $_fileName',
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(
                'Error: $_error',
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
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
              child: const Icon(Icons.arrow_back),
              onTap: () => Get.back(),
            ),
            ElevatedButton(
              onPressed: _handleContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE9725A),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
