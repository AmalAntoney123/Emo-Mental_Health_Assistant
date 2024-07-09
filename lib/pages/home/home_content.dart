import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          "What are you looking for? ",
          style: TextStyle(
              fontSize: 28, color: Theme.of(context).colorScheme.primary),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
        buildCard(
          title: 'Doctors',
          subtitle: 'Find the perfect doctors that fits your needs.',
          icon: Icons.medical_services,
          color: Colors.red,
          bgColor: Colors.red[100]!,
        ),
        SizedBox(height: 16),
        buildCard(
          title: 'Workouts',
          subtitle: 'We have all the workouts you need.',
          icon: Icons.fitness_center,
          color: Colors.blue,
          bgColor: Colors.blue[100]!,
        ),
        SizedBox(height: 16),
        buildCard(
          title: 'Events',
          subtitle: 'Check the events happening in your city.',
          icon: Icons.event,
          color: Colors.green,
          bgColor: Colors.green[100]!,
        ),
      ],
    );
  }

  Widget buildCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    return SizedBox(
      height: 160,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: bgColor,
            child: Icon(icon, color: color),
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}