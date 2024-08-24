import 'dart:convert';

import 'package:myapp/api/API.dart';
import 'package:myapp/models/signup.dart';
import 'package:myapp/models/signup4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/signup_controller.dart';
import 'package:myapp/screens/signupscreens/signup_screen5.dart';

class SignUpScreen4 extends StatefulWidget {
  const SignUpScreen4({super.key});

  @override
  State<SignUpScreen4> createState() => _SignUpScreen4State();
}

class _SignUpScreen4State extends State<SignUpScreen4> {
  int _selectedDayIndex = -1;
  bool _isProcessing = false;

  final Map<String, Set<String>> _businessHours = {
    "mon": {},
    "tue": {},
    "wed": {},
    "thu": {},
    "fri": {},
    "sat": {},
    "sun": {},
  };

  final List<String> _days = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];
  final List<String> _timeSlots = [
    "08:00 AM",
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "01:00 PM",
  ];

  final SignUpController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 18, vertical: height / 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Signup 4 of 4',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Business Hours',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height / 50),
                  SizedBox(height: height / 30),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(_days.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDayIndex = index;
                          });
                        },
                        child: _buildDayButton(
                          day: _getDayName(index),
                          isSelected: _selectedDayIndex == index,
                          hasSelectedTimeSlots:
                              _businessHours[_days[index]]!.isNotEmpty,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: height / 35),
                  if (_selectedDayIndex != -1) ...[
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _timeSlots.map((slot) {
                        return _buildTimeSlot(slot, width);
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(width / 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: width / 30, horizontal: width / 5),
                        backgroundColor: const Color(0xFFD5715B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: _isProcessing
                          ? null
                          : () async {
                              setState(() {
                                _isProcessing = true; // Disable the button
                              });

                              try {
                                if (_selectedDayIndex != -1) {
                                  _saveSelectedHours();

                                  final businessHours = BusinessHours(
                                    _businessHours.map(
                                      (key, value) =>
                                          MapEntry(key, value.toList()),
                                    ),
                                  );

                                  final superModel = SuperModel(
                                    signUp: controller.signUpData.value,
                                    farmInfo: controller.farmInfo.value,
                                    verification: controller.verification.value,
                                    businessHours: businessHours,
                                    socialLoginInfo:
                                        controller.socialLoginInfo.value,
                                    // Hardcoded
                                  );

                                  final apiService = ApiService();
                                  final jsonBody =
                                      jsonEncode(superModel.toJson());

                                  // Print the JSON body to the console
                                  print('Sending JSON: $jsonBody');

                                  await apiService.registerUser(superModel);

                                  setState(() {
                                    _isProcessing =
                                        false; // Re-enable the button if needed
                                  });

                                  Get.to(() => const SignUpScreen5());
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please select at least one day.'),
                                    ),
                                  );
                                }
                              } catch (e) {
                                print('Error during registration: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'An error occurred during registration. Please try again.'),
                                  ),
                                );

                                setState(() {
                                  _isProcessing =
                                      false; // Re-enable the button if needed
                                });
                              }
                            },
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayButton({
    required String day,
    required bool isSelected,
    required bool hasSelectedTimeSlots,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFD5715B)
            : hasSelectedTimeSlots
                ? Colors.grey
                : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey[300]!,
        ),
      ),
      child: Text(
        day,
        style: TextStyle(
          fontSize: 16,
          color:
              isSelected || hasSelectedTimeSlots ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTimeSlot(String time, double width) {
    if (_selectedDayIndex < 0 || _selectedDayIndex >= _days.length) {
      return Container(); // Or handle error
    }

    final selectedDay = _days[_selectedDayIndex];
    final timeSlotsForDay = _businessHours[selectedDay] ?? {};
    bool isSelected = timeSlotsForDay.contains(time);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            timeSlotsForDay.remove(time);
          } else {
            timeSlotsForDay.add(time);
          }
        });
      },
      child: Container(
        width: (width - (2 * (width / 18)) - 8.0) / 2,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8C569) : Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          time,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  String _getDayName(int index) {
    List<String> days = ["M", "T", "W", "Th", "F", "S", "Su"];
    return days[index];
  }

  void _saveSelectedHours() {
    if (_selectedDayIndex < 0 || _selectedDayIndex >= _days.length) return;

    final selectedDay = _days[_selectedDayIndex];
    _businessHours[selectedDay] = _businessHours[selectedDay] ?? {};
  }
}
