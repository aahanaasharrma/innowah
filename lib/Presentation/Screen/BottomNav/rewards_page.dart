import 'package:flutter/material.dart';

class RewardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Color(0xFFAEC6A5), // Set background color to light green
              padding: EdgeInsets.symmetric(vertical: 50.0),
              child: Center(
                child: Text(
                  ''
                      'Rewards',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3A4F3B), // Set dark green color
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.0),
            Text(
              'Available Rewards',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.0),

            // Placeholder for Logo (Replace with your logo widget)
            Image.asset(
              'assets/images/reward.png',
              height: 650, // Set height
              width: 550, // Set width
              fit: BoxFit.contain, // Adjust the fit according to your needs
            ),


            SizedBox(height: 20.0),

            // Text: Description

          ],
        ),
      ),
      backgroundColor: Colors.white, // Set background color of the bottom portion to white
    );
  }
}
