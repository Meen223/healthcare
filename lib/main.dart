import 'package:flutter/material.dart';
import 'screens/health/Home.dart'; // Import หน้า Home
import 'screens/auth/LoginPage.dart';
import 'screens/health/Summary.dart'; // Import หน้า Summary
import 'screens/settings/Notification.dart'; // Import หน้า Notification
import 'screens/settings/Setting.dart'; // Import หน้า Setting
import 'package:healthcare/providers/auth_provider.dart';
import 'package:healthcare/providers/food_record_provider.dart';
import 'package:provider/provider.dart';
// import 'package:healthcare/screens/ health/FoodRecord.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          print('AuthProvider initialized');
          return AuthProvider()..loadToken();
        }),
        ChangeNotifierProvider(create: (_) => FoodRecordProvider()), // เพิ่ม Provider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.cyan,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: LoginScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Home(),
    SummaryGraphScreen(),
    NotificationScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (!authProvider.isAuthenticated) {
      return LoginScreen();
    }

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Summary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
