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
  final int totalSteps = 5;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String? gender;
  final TextEditingController countryController = TextEditingController();
  String? mentalHealthGoal;
  List<String> selectedInterests = [];

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: OnBoardingSlider(
        headerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        finishButtonText: 'Submit',
        background: List.generate(
            5,
            (index) =>
                Container(color: Theme.of(context).scaffoldBackgroundColor)),
        totalPage: 5,
        speed: 1.8,
        pageBodies: [
          _buildNameStep(),
          _buildAgeGenderStep(),
          _buildCountryStep(),
          _buildMentalHealthGoalStep(),
          _buildInterestsStep(),
        ],
        onFinish: () {
          if (_formKey.currentState!.validate()) {
            _submitUserInfo();
          }
        },
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          foregroundColor: Theme.of(context).colorScheme.background,
          elevation: 3,
        ),
      ),
    );
  }

  Widget _buildNameStep() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 60),
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
                TextFormField(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.length < 2) {
                      return 'Name must be at least 2 characters long';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildAgeGenderStep() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 60),
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
                TextFormField(
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
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    int? age = int.tryParse(value);
                    if (age == null || age < 13 || age > 120) {
                      return 'Please enter a valid age between 13 and 120';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a gender';
                    }
                    return null;
                  },
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildCountryStep() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 60),
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
                TextFormField(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your country';
                    }
                    if (value.length < 2) {
                      return 'Country name must be at least 2 characters long';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildMentalHealthGoalStep() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 60),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a mental health goal';
                    }
                    return null;
                  },
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildInterestsStep() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 60),
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
                  SizedBox(height: 20),
                  if (selectedInterests.isEmpty)
                    Text(
                      'Please select at least one interest',
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitUserInfo() async {
    if (selectedInterests.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select at least one interest')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final databaseReference = FirebaseDatabase.instance.ref();

        // Create the user data map
        final userData = {
          'name': nameController.text,
          'age': int.parse(ageController.text),
          'gender': gender,
          'country': countryController.text,
          'mentalHealthGoal': mentalHealthGoal,
          'interests': selectedInterests,
        };

        // Attempt to set the data and await the result
        await databaseReference.child('users').child(user.uid).set(userData);

        // Navigate to the main app screen
        Navigator.pushReplacementNamed(context, Routes.homeScreen);
      } else {
        throw Exception('No authenticated user found');
      }
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Firebase error: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unknown error occurred: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
