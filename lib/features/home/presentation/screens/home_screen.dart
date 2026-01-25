import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/home/presentation/screens/bmi.dart';
import 'package:bmi_tracker/features/profile/presentation/screens/profile.dart';
import 'package:bmi_tracker/gen/colors.gen.dart';
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

  final List<Widget> _pages = [BmiScreen(), ProfileScreen()];
  final List<String> _pageName = ["BMI", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: appTextS1(_pageName[current_index]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.black,
        unselectedItemColor: AppColors.black.withAlpha(80),
        currentIndex: current_index,
        onTap: _navigateScreen,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: _pages[current_index],
    );
  }
}
