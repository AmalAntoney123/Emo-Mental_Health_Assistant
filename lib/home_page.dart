import 'package:emo/main_pages/home_content.dart';
import 'package:emo/main_pages/profile_page.dart';
import 'package:emo/navigation/navigation.dart';
import 'package:emo/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeContent(),
    SearchContent(),
    MessageContent(),
    ProfileContent(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthentication();
    });
  }

  void _checkAuthentication() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.loginScreen);
      }
    }
  }

  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
      await Future.delayed(Duration(milliseconds: 200));
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.loginScreen, (Route<dynamic> route) => false);
      }
    } catch (e) {
      print("Error during logout: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('An error occurred during logout. Please try again.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu,
              color: Theme.of(context).colorScheme.onBackground),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCounter(Icons.local_fire_department, 5, context),
            SizedBox(width: 16),
            _buildCounter(Icons.local_play, 100, context),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person,
                color: Theme.of(context).colorScheme.onBackground),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: _screens[_currentIndex],
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: SizedBox(
        width: 72,
        height: 72,
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 2.0,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          child: Icon(Icons.add,
              size: 30, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildFloatingBottomAppBar(),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            child: Text(
              'Emo',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle settings tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {
              // Handle help tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              _logout();
            },
          ),
          ListTile(
            leading: Icon(Icons.sunny),
            title: Text('Theme'),
            onTap: () => Provider.of<ThemeNotifier>(context, listen: false)
                .toggleTheme(),
          ),
          // Add more ListTiles for additional menu items
        ],
      ),
    );
  }

  Widget _buildFloatingBottomAppBar() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20, left: 16, right: 16),
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BottomAppBar(
            elevation: 0,
            color: Theme.of(context).colorScheme.background,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () => setState(() => _currentIndex = 0),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => setState(() => _currentIndex = 1),
                  ),
                  SizedBox(width: 60),
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () => setState(() => _currentIndex = 2),
                  ),
                  IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () => setState(() => _currentIndex = 3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCounter(IconData icon, int count, BuildContext context,
      {Color? iconColor}) {
    Color getIconColor() {
      if (icon == Icons.local_fire_department) return Colors.orange;
      if (icon == Icons.local_play) return Colors.blue;
      return iconColor ?? Theme.of(context).colorScheme.onBackground;
    }

    return Row(
      children: [
        Icon(icon, color: getIconColor(), size: 20),
        SizedBox(width: 4),
        Text(
          count.toString(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class SearchContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Search Screen'));
  }
}

class MessageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Message Screen'));
  }
}

class ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Screen'));
  }
}
