import 'package:flutter/material.dart';
import 'package:mutualibri/screens/welcome/button_login_logout.dart';
import 'package:mutualibri/screens/welcome/welcome_image.dart';

import '../../components/background.dart';
import '../../responsive.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileWelcomeScreen(),
          desktop: DesktopWelcomeScreen(),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const WelcomeImage(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const LoginAndSignupBtn(),
        ),
      ],
    );
  }
}

class DesktopWelcomeScreen extends StatelessWidget {
  const DesktopWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: WelcomeImage(),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: const LoginAndSignupBtn(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
