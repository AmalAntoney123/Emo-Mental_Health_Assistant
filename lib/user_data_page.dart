// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text("Complete Your Profile",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildStep(),
                ),
              ),
            ),
            IconStepper(
              icons: [
                Icon(Icons.person),
                Icon(Icons.cake),
                Icon(Icons.flag),
                Icon(Icons.psychology),
                Icon(Icons.interests),
              ],
              activeStep: activeStep,
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
              activeStepColor: Theme.of(context).colorScheme.onPrimary,
              lineColor: Theme.of(context).colorScheme.onPrimary,
              lineLength: 50,
              enableNextPreviousButtons: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (activeStep) {
      case 0:
        return _buildNameStep();
      case 1:
        return _buildAgeGenderStep();
      case 2:
        return _buildCountryStep();
      case 3:
        return _buildMentalHealthGoalStep();
      case 4:
        return _buildInterestsStep();
      default:
        return Container();
    }
  }

  Widget _buildNameStep() {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 140,
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              labelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          SizedBox(height: 20),
          _buildNextButton(() {
            if (nameController.text.isNotEmpty) {
              setState(() {
                activeStep++;
              });
            }
          }),
        ],
      ),
    );
  }

  Widget _buildAgeGenderStep() {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 140,
          ),
          TextField(
            controller: ageController,
            decoration: InputDecoration(
              labelText: 'Age',
              labelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          SizedBox(height: 20),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Gender',
              labelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
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
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          SizedBox(height: 20),
          _buildNextButton(() {
            if (ageController.text.isNotEmpty && gender != null) {
              setState(() {
                activeStep++;
              });
            }
          }),
        ],
      ),
    );
  }

  Widget _buildCountryStep() {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 140,
          ),
          TextField(
            controller: countryController,
            decoration: InputDecoration(
              labelText: 'Country',
              labelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          SizedBox(height: 20),
          _buildNextButton(() {
            if (countryController.text.isNotEmpty) {
              setState(() {
                activeStep++;
              });
            }
          }),
        ],
      ),
    );
  }

  Widget _buildMentalHealthGoalStep() {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 140,
          ),
          Text(
            'What is your primary mental health goal?',
            style: TextStyle(
                fontSize: 18, color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Goal',
              labelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
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
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          SizedBox(height: 20),
          _buildNextButton(() {
            if (mentalHealthGoal != null) {
              setState(() {
                activeStep++;
              });
            }
          }),
        ],
      ),
    );
  }

  Widget _buildInterestsStep() {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            'Select your interests (max 5):',
            style: TextStyle(
                fontSize: 18, color: Theme.of(context).colorScheme.primary),
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
                selectedColor:
                    Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
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
          ElevatedButton(
            onPressed: isLoading ? null : _submitUserInfo,
            child: isLoading
                ? CircularProgressIndicator()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.done,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Submit',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_forward,
              color: Theme.of(context).colorScheme.onBackground),
          SizedBox(width: 10),
          Text(
            'Next',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 20,
            ),
          ),
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
        Navigator.of(context).pushReplacementNamed('/home');
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
