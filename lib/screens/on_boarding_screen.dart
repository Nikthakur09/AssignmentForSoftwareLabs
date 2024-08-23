import 'package:myapp/screens/loginscreens/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: [
                OnboardingPage(
                  imagePath: 'assets/images/1.png',
                  title: 'Quality',
                  description:
                      'Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain.',
                  buttonColor: Colors.green,
                  currentIndex: currentIndex,
                  pageIndex: 0,
                  pageController: _pageController,
                ),
                OnboardingPage(
                  imagePath: 'assets/images/2.png',
                  title: 'Convenient',
                  description:
                      'Our team of delivery drivers will make sure your orders are picked up on time and promptly delivered to your customers.',
                  buttonColor: Colors.orange,
                  currentIndex: currentIndex,
                  pageIndex: 1,
                  pageController: _pageController,
                ),
                OnboardingPage(
                  imagePath: 'assets/images/3.png',
                  title: 'Local',
                  description:
                      'We love the earth and know you do too! Join us in reducing our local carbon footprint one order at a time.',
                  buttonColor: Colors.yellow,
                  currentIndex: currentIndex,
                  pageIndex: 2,
                  pageController: _pageController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Color buttonColor;
  final int currentIndex;
  final int pageIndex;
  final PageController pageController;

  const OnboardingPage({super.key, 
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonColor,
    required this.currentIndex,
    required this.pageIndex,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image portion
        Positioned.fill(
          bottom: MediaQuery.of(context).size.height * 0.46,
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
        ),
        // White container with rounded edges on top
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      width: currentIndex == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: currentIndex == index
                            ? BoxShape.rectangle
                            : BoxShape.circle,
                        color:
                            currentIndex == index ? Colors.black : Colors.grey,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (pageIndex == 2) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: const Text(
                    'Join the movement!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Get.to(() => LoginScreen());
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
