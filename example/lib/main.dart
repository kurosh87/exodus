import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_screen.dart';
import 'services_screen.dart';
import 'community_screen.dart';
import 'settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final accessToken = const String.fromEnvironment("ACCESS_TOKEN",
      defaultValue: 'pk.eyJ1IjoicmVhbGVzdGF0ZWJvdCIsImEiOiJjbTMzM2d5dWoxOXhlMmlzNG01YmgwY2x1In0.yv0Nac7EjmWZvjg40KS6nw');
  MapboxOptions.setAccessToken(accessToken);
  runApp(const ExodusApp());
}

class ExodusApp extends StatelessWidget {
  const ExodusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exodus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1E88E5),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1E88E5),
        brightness: Brightness.dark,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: [
              const HomeScreen(),
              const ServicesScreen(),
              const CommunityScreen(),
              SettingsScreen(),
            ],
          ),
          if (_selectedIndex == 0)
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              child: SvgPicture.asset(
                'assets/images/exodus_logo.svg',
                height: 30,
                color: isDarkMode ? Colors.white : null,
              ),
            ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.business_center_outlined),
            selectedIcon: Icon(Icons.business_center),
            label: 'Services',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Community',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
