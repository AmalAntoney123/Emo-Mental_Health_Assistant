// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emo/login_page.dart';
import 'package:flutter/material.dart';
import 'package:introduction_slider/introduction_slider.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: IntroductionSlider(
          items: [
            IntroductionSliderItem(
              title: Text(
                "Hey there, I'm Emo!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                "Your friendly guide to a happier mind!",
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              logo: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.all(
                          Radius.circular(60)) // White background color
                      ),
                  child: ClipRect(
                    child: Image.asset(
                      'assets/hi-emo.png',
                      color: Theme.of(context).colorScheme.onPrimary,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            IntroductionSliderItem(
              title: Text(
                "Let's Track Your Mood!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                "Complete fun quizzes, earn streaks, and collect rewards!",
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              logo: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.all(
                          Radius.circular(60)) // White background color
                      ),
                  child: ClipRect(
                    child: Image.asset(
                      'assets/smile-emo.png',
                      color: Theme.of(context).colorScheme.onPrimary,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            IntroductionSliderItem(
              title: Text(
                "Discover Personalized Support!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                "From AI insights to virtual therapy sessions, I've got you covered!",
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              logo: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.all(
                          Radius.circular(60)) // White background color
                      ),
                  child: ClipRect(
                    child: Image.asset(
                      'assets/down-emo.png',
                      color: Theme.of(context).colorScheme.onPrimary,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
          done: Done(
            child: Icon(Icons.done),
            home: LoginScreen(),
            // Navigate to login page after completion
          ),
          next: Next(child: Icon(Icons.arrow_forward)),
          back: Back(child: Icon(Icons.arrow_back)),
          dotIndicator: DotIndicator(
            selectedColor: Theme.of(context).colorScheme.onPrimary,
          ),
          initialPage: 0, // Initial page index
          showStatusBar: true, // Show status bar (default is false)
          physics: ScrollPhysics(), // Scroll physics, customize as needed
          scrollDirection: Axis.horizontal, // Scroll direction
        ),
      ),
    );
  }
}
