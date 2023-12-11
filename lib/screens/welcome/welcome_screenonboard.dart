import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          OnboardingPage(
            title: 'Welcome to MyApp',
            description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            imagePath: 'assets/onboarding/onboarding1.png',
          ),
          OnboardingPage(
            title: 'Discover Exciting Features',
            description: 'Explore the amazing features that MyApp has to offer.',
            imagePath: 'assets/onboarding/onboarding2.png',
          ),
          OnboardingPage(
            title: 'Get Started Now',
            description: 'Sign up and start enjoying MyApp today!',
            imagePath: 'assets/onboarding/onboarding3.png',
          ),
        ],
      ),
      bottomSheet: _currentPage == 2
          ? Container(
              width: double.infinity,
              height: 60,
              color: Colors.blue,
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press, e.g., navigate to the next screen
                },
                child: Text('Get Started'),
              ),
            )
          : null,
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          description,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Image.asset(
          imagePath,
          height: 200,
        ),
      ],
    );
  }
}