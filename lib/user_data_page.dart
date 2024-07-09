// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:emo/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataCollection extends StatefulWidget {
  const UserDataCollection({Key? key}) : super(key: key);

  @override
  _UserDataCollectionState createState() => _UserDataCollectionState();
}

class _UserDataCollectionState extends State<UserDataCollection> {
  int activeStep = 0;
  final int totalSteps = 6;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String? gender;
  final TextEditingController countryController = TextEditingController();
  String? mentalHealthGoal;
  List<String> selectedInterests = [];
  bool isTherapist = false;

  bool isLoading = false;

  final List<String> interests = [
    'Meditation',
    'Yoga',
    'Reading',
    'Exercise',
    'Art',
    'Music',
    'Nature',
    'Cooking',
    'Writing',
    'Socializing',
    'Mindfulness',
    'Therapy',
    'Self-care',
    'Journaling',
    'Spirituality',
    'Gratitude',
    'Breathing exercises',
    'Healthy eating',
    'Sleep hygiene',
    'Stress management'
  ];

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      headerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      finishButtonText: 'Submit',
      background: [
        Container(color: Theme.of(context).scaffoldBackgroundColor),
        Container(color: Theme.of(context).scaffoldBackgroundColor),
        Container(color: Theme.of(context).scaffoldBackgroundColor),
        Container(color: Theme.of(context).scaffoldBackgroundColor),
        Container(color: Theme.of(context).scaffoldBackgroundColor),
      ],
      controllerColor: Theme.of(context).colorScheme.onPrimary,
      totalPage: 5,
      speed: 1.8,
      pageBodies: [
        _buildNameStep(),
        _buildAgeGenderStep(),
        _buildCountryStep(),
        _buildMentalHealthGoalStep(),
        _buildInterestsStep(),
      ],
      onFinish: _submitUserInfo,
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: Theme.of(context)
            .colorScheme
            .onPrimary, // Set your desired button background color
        foregroundColor: Theme.of(context)
            .colorScheme
            .background, // Set your desired text (foreground) color
        elevation:
            3, // Adjust elevation as needed// Adjust text style as needed
      ),
    );
  }

  Widget _buildNameStep() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 60), // Added space at the top
          Text(
            'Emo',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            // This will push the content to the center
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'What\'s your name?',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ],
            ),
          ),
          SizedBox(height: 60), // Added space at the bottom
        ],
      ),
    );
  }

  Widget _buildAgeGenderStep() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 60), // Added space at the top
          Text(
            'Emo',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            // This will push the content to the center
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Tell us about yourself',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  isExpanded: true,
                  value: gender,
                  hint: Text('Select Gender'),
                  items: ['Male', 'Female', 'Non-binary', 'Prefer not to say']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      gender = newValue;
                    });
                  },
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ],
            ),
          ),
          SizedBox(height: 60), // Added space at the bottom
        ],
      ),
    );
  }

  Widget _buildCountryStep() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 60), // Added space at the top
          Text(
            'Emo',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            // This will push the content to the center
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Where are you from?',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                TextField(
                  controller: countryController,
                  decoration: InputDecoration(
                    labelText: 'Country',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ],
            ),
          ),
          SizedBox(height: 60), // Added space at the bottom
        ],
      ),
    );
  }

  Widget _buildMentalHealthGoalStep() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 60), // Added space at the top
          Text(
            'Emo',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            // This will push the content to the center
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'What is your primary mental health goal?',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Goal',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  isExpanded: true,
                  value: mentalHealthGoal,
                  hint: Text('Select Goal'),
                  items: [
                    'Reduce Stress',
                    'Improve Mood',
                    'Increase Productivity',
                    'Better Sleep',
                    'Manage Anxiety',
                    'Other'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      mentalHealthGoal = newValue;
                    });
                  },
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ],
            ),
          ),
          SizedBox(height: 60), // Added space at the bottom
        ],
      ),
    );
  }

  Widget _buildInterestsStep() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 60), // Added space at the top
          Text(
            'Emo',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            // This will push the content to the center
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Select your interests:',
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: interests.map((interest) {
                      final isSelected = selectedInterests.contains(interest);
                      return FilterChip(
                        label: Text(
                          interest,
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.7)
                                : Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              if (selectedInterests.length < 5) {
                                selectedInterests.add(interest);
                              }
                            } else {
                              selectedInterests.remove(interest);
                            }
                          });
                        },
                        selectedColor: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.2),
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ), // Added space at the bottom
        ],
      ),
    );
  }

  Future<void> _submitUserInfo() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final databaseReference = FirebaseDatabase.instance.ref();
        await databaseReference.child('users').child(user.uid).set({
          'name': nameController.text,
          'age': int.parse(ageController.text),
          'gender': gender,
          'country': countryController.text,
          'mentalHealthGoal': mentalHealthGoal,
          'interests': selectedInterests,
        });

        // Navigate to the main app screen
        Navigator.pushReplacementNamed(context, Routes.homeScreen);
      }
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving user info: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
