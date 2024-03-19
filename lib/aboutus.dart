import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/AboutUs.png', // Path to your background image asset
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}