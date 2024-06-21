import 'package:emo/widgets/option_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "What are you looking for? ",
            style: TextStyle(
                fontSize: 28, color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Container(
            height: 160,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red[100],
                  child: Icon(Icons.medical_services, color: Colors.red),
                ),
                title: Text('Doctors',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle:
                    Text('Find the perfect doctors that fits your needs.'),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 160,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: Icon(Icons.fitness_center, color: Colors.blue),
                ),
                title: Text('Workouts',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('We have all the workouts you need.'),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 160,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green[100],
                  child: Icon(Icons.event, color: Colors.green),
                ),
                title: Text('Events',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Check the events happening in your city.'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 72, // Increased size
        height: 72, // Increased size
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30, // Increased icon size
          ),
          onPressed: () {},
          elevation: 2.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildFloatingBottomAppBar(),
    );
  }
}

Widget _buildFloatingBottomAppBar() {
  return Padding(
    padding: EdgeInsets.only(bottom: 20, left: 16, right: 16),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomAppBar(
          color: Colors.white,
          notchMargin: 8.0,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(icon: Icon(Icons.home), onPressed: () {}),
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                SizedBox(width: 60), // Increased space for FAB
                IconButton(icon: Icon(Icons.message), onPressed: () {}),
                IconButton(icon: Icon(Icons.person), onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
