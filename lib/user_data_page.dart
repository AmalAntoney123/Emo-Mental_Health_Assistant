import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserDataCollection extends StatefulWidget {
  @override
  _UserDataCollectionState createState() => _UserDataCollectionState();
}

class _UserDataCollectionState extends State<UserDataCollection> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  String name = '';
  DateTime? dateOfBirth;
  String gender = '';
  String? phoneNumber;
  Map<String, String> address = {};
  List<String> mentalHealthConditions = [];
  List<String> goals = ['', ''];
  String preferredLanguage = 'English';
  List<String> interests = [];

  List<Step> get _steps => [
        _buildPersonalInfoStep(),
        _buildContactInfoStep(),
        _buildHealthInfoStep(),
        _buildPreferencesStep(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stepper(
            currentStep: _currentStep,
            onStepContinue: _next,
            onStepCancel: _cancel,
            steps: _steps,
          ),
        ),
      ),
    );
  }

  Step _buildPersonalInfoStep() {
    return Step(
      title: Text('Personal Information'),
      content: Column(
        children: [
          _buildTextField(
            controller: TextEditingController(text: name),
            labelText: 'Name',
            onChanged: (value) => name = value,
            validator: (value) =>
                value!.isEmpty ? 'Please enter your name' : null,
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (picked != null) setState(() => dateOfBirth = picked);
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text(
                dateOfBirth != null
                    ? DateFormat('yyyy-MM-dd').format(dateOfBirth!)
                    : 'Select Date',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildDropdownField(
            value: gender,
            labelText: 'Gender',
            items: ['Male', 'Female', 'Other'],
            onChanged: (value) => setState(() => gender = value!),
            validator: (value) => value == null ? 'Please select gender' : null,
          ),
        ],
      ),
      isActive: _currentStep >= 0,
    );
  }

  Step _buildContactInfoStep() {
    return Step(
      title: Text('Contact Information'),
      content: Column(
        children: [
          _buildTextField(
            controller: TextEditingController(text: phoneNumber),
            labelText: 'Phone Number (Optional)',
            keyboardType: TextInputType.phone,
            onChanged: (value) => phoneNumber = value,
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: TextEditingController(text: address['street']),
            labelText: 'Street',
            onChanged: (value) => address['street'] = value,
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: TextEditingController(text: address['city']),
            labelText: 'City',
            onChanged: (value) => address['city'] = value,
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: TextEditingController(text: address['state']),
            labelText: 'State',
            onChanged: (value) => address['state'] = value,
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: TextEditingController(text: address['country']),
            labelText: 'Country',
            onChanged: (value) => address['country'] = value,
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: TextEditingController(text: address['postalCode']),
            labelText: 'Postal Code',
            onChanged: (value) => address['postalCode'] = value,
          ),
        ],
      ),
      isActive: _currentStep >= 1,
    );
  }

  Step _buildHealthInfoStep() {
    return Step(
      title: Text('Health Information'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mental Health Conditions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          _buildCheckboxListTile('Anxiety', 'Anxiety'),
          _buildCheckboxListTile('Depression', 'Depression'),
          SizedBox(height: 20),
          Text('Goals',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildTextField(
            controller: TextEditingController(text: goals[0]),
            labelText: 'Goal 1',
            onChanged: (value) => goals[0] = value,
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: TextEditingController(text: goals[1]),
            labelText: 'Goal 2',
            onChanged: (value) => goals[1] = value,
          ),
        ],
      ),
      isActive: _currentStep >= 2,
    );
  }

  Step _buildPreferencesStep() {
    return Step(
      title: Text('Preferences'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdownField(
            value: preferredLanguage,
            labelText: 'Preferred Language',
            items: ['English', 'Spanish', 'French', 'German'],
            onChanged: (value) => setState(() => preferredLanguage = value!),
          ),
          SizedBox(height: 20),
          Text('Interests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          _buildCheckboxListTile('Stress Management', 'Stress Management'),
          _buildCheckboxListTile('Mindfulness', 'Mindfulness'),
        ],
      ),
      isActive: _currentStep >= 3,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    required Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownField({
    required String value,
    required String labelText,
    required List<String> items,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value.isNotEmpty ? value : null,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      items: items.map((String item) {
        return DropdownMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildCheckboxListTile(String title, String value) {
    return CheckboxListTile(
      title: Text(title,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      value: mentalHealthConditions.contains(value),
      onChanged: (bool? checked) {
        setState(() {
          if (checked!) {
            mentalHealthConditions.add(value);
          } else {
            mentalHealthConditions.remove(value);
          }
        });
      },
    );
  }

  void _next() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    } else {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // Here you would typically send the data to a server or save it locally
        print(
            'Data collected: $name, $dateOfBirth, $gender, $phoneNumber, $address, $mentalHealthConditions, $goals, $preferredLanguage, $interests');
      }
    }
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }
}
