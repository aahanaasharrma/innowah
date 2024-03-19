import 'package:flutter/material.dart';

class RewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/Rewards_Page.png', // Path to your background image asset
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}