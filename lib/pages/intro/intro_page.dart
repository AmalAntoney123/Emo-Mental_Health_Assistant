import 'package:emo/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Get Started',
      onFinish: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      skipTextButton: Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      controllerColor: Theme.of(context).colorScheme.onPrimary,
      totalPage: 3,
      headerBackgroundColor: Theme.of(context).colorScheme.background,
      pageBackgroundColor: Theme.of(context).colorScheme.background,
      background: [
        _buildLogoContainer(context, 'assets/hi-emo.png'),
        _buildLogoContainer(context, 'assets/smile-emo.png'),
        _buildLogoContainer(context, 'assets/down-emo.png'),
      ],
      speed: 1.8,
      pageBodies: [
        _buildPageContent(
          context,
          "Hey there, I'm Emo!",
          "Your friendly guide to a happier mind!",
        ),
        _buildPageContent(
          context,
          "Let's Track Your Mood!",
          "Complete fun quizzes, earn streaks, and collect rewards!",
        ),
        _buildPageContent(
          context,
          "Discover Personalized Support!",
          "From AI insights to virtual therapy sessions, I've got you covered!",
        ),
      ],
    );
  }

  Widget _buildLogoContainer(BuildContext context, String assetPath) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.all(Radius.circular(60)),
            ),
            child: ClipRect(
              child: Image.asset(
                assetPath,
                color: Theme.of(context).colorScheme.onPrimary,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(
      BuildContext context, String title, String subtitle) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        ],
      ),
    );
  }
}
