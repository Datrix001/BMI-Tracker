import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/home/presentation/screens/analyse.dart';
import 'package:bmi_tracker/features/home/presentation/screens/bmi.dart';
import 'package:bmi_tracker/features/profile/presentation/screens/profile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "/home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var current_index = 0;

  void _navigateScreen(int index) {
    setState(() {
      current_index = index;
    });
  }

  final List<Widget> _pages = [BmiScreen(), AnalyseScreen(), ProfileScreen()];
  final List<String> _pageName = ["BMI", "Analyse", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: appTextS1(_pageName[current_index]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current_index,
        onTap: _navigateScreen,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Analyse",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: _pages[current_index],
    );
  }
}
