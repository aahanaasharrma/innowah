import 'package:flutter/material.dart';

class CycleRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/cycleroute.jpg',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}