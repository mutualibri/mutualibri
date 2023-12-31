// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mutualibri/models/onboard_model.dart';
import 'package:mutualibri/screens/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/images/Logo.png',
      text: "Belajar Dengan Metode Learning by Doing",
      desc:
          "Sebuah metode belajar yang terbuktiampuh dalam meningkatkan produktifitas belajar, Learning by Doing",
      bg: Colors.white,
      button: const Color(0xFFFBB825),
    ),
    OnboardModel(
      img: 'assets/images/Logo.png',
      text: "Empower Your Expertise",
      desc: "Dive Deeper with Collaborative Skill Building!",
      bg: const Color(0xFFFBB825),
      button: Colors.white,
    ),
    OnboardModel(
      img: 'assets/images/Logo.png',
      text: "Gunakan Fitur Kolaborasi Untuk Pengalaman Lebih",
      desc:
          "Tersedia fitur Kolaborasi dengan tujuan untuk mengasah skill lebih dalam karena bias belajar bersama",
      bg: Colors.white,
      button: const Color(0xFFFBB825),
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex % 2 == 0 ? kwhite : kPrimaryColor,
      appBar: AppBar(
        backgroundColor: currentIndex % 2 == 0 ? kwhite : kPrimaryColor,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              _storeOnboardInfo();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelcomeScreen()));
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: currentIndex % 2 == 0 ? kblack : kwhite,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(screens[index].img),
                    Container(
                      height: 10.0,
                      child: ListView.builder(
                        itemCount: screens.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  width: currentIndex == index ? 25 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: currentIndex == index
                                        ? kbrown
                                        : kbrown300,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ]);
                        },
                      ),
                    ),
                    Text(
                      screens[index].text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: index % 2 == 0 ? kblack : kwhite,
                      ),
                    ),
                    Text(
                      screens[index].desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Montserrat',
                        color: index % 2 == 0 ? kblack : kwhite,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        print(index);
                        if (index == screens.length - 1) {
                          await _storeOnboardInfo();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomeScreen()));
                        }

                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.bounceIn,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10),
                        decoration: BoxDecoration(
                            color: index % 2 == 0 ? kPrimaryColor : kwhite,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: index % 2 == 0 ? kwhite : kPrimaryColor),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Icon(
                            Icons.arrow_forward_sharp,
                            color: index % 2 == 0 ? kwhite : kPrimaryColor,
                          )
                        ]),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
