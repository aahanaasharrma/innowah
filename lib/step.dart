import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepCounter extends StatefulWidget {
  const StepCounter({Key? key}) : super(key: key);

  @override
  _StepCounterState createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  int steps = 0;
  double exactDistance = 0.0;
  double previousDistance = 0.0;

  StreamSubscription<AccelerometerEvent>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _loadSteps(); // Load the stored steps count
    _streamSubscription =
        SensorsPlatform.instance.accelerometerEvents.listen((event) {
          setState(() {
            x = event.x;
            y = event.y;
            z = event.z;
            exactDistance = _calculateMagnitude(x, y, z);
            if (exactDistance > 6) {
              steps++;
              _saveSteps(steps); // Save the updated steps count
            }
          });
        });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Color(0xFFB0C7A6),
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text(
                'Step Tracker',
                style: TextStyle(
                  color: (Color(0xFF3A4F3B)),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20), // Add space below the Step Tracker title
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Today',
                          style: TextStyle(
                            color: Color(0xFF4C6144),
                            fontSize: 24, // Adjusted font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 12), // Add space below Today text
                      _buildInfoBox(
                          'Steps', steps.toString(), 'assets/images/step.png', Color(0xFFE5F4DE)),
                    ],
                  ),
                  _buildInfoBox(
                      'Total Distance', _calculateDistance(), 'assets/images/distance.png', Color(0xFFE5F4DE)),
                  _buildInfoBox(
                      'Calories Burnt', _calculateCalories(), 'assets/images/calorie.png', Color(0xFFE5F4DE)),
                  SizedBox(height: 0), // Add space between boxes and the image
                  Center(
                    child: Image.asset(
                      'assets/images/step_logo.png', // Adjust path to your image
                      width: 350, // Set the width as desired
                      height: 200, // Set the height as desired
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateDistance() {
    // Assuming a constant distance per step
    final double distancePerStep = 0.0008; // Modify this value as needed
    return (steps * distancePerStep).toStringAsFixed(3); // Fixed to 2 decimal places
  }

  String _calculateCalories() {
    // Assuming a constant calories burned per step
    final double caloriesPerStep = 0.04; // Modify this value as needed
    return (steps * caloriesPerStep).toStringAsFixed(2); // Fixed to 2 decimal places
  }

  Widget _buildInfoBox(String title, String value, String iconPath, Color color) {
    String label = '';
    switch (title) {
      case 'Steps':
        label = 'Steps';
        break;
      case 'Total Distance':
        label = 'Kms';
        break;
      case 'Calories Burnt':
        label = 'Kcals';
        break;
      default:
        label = '';
    }
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                iconPath,
                width: 30,
                height: 30,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFF3A4F3B),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: Color(0xFF3A4F3B),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),

              ),
              SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: Color(0xFF737373),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _calculateMagnitude(double x, double y, double z) {
    double distance = sqrt(x * x + y * y + z * z);
    _getPreviousValue();
    double mode = distance - previousDistance;
    _setPrefData(distance);
    return mode;
  }

  Future<void> _setPrefData(double predistance) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setDouble("previousDistance", predistance);
  }

  Future<void> _getPreviousValue() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      previousDistance = _pref.getDouble("previousDistance") ?? 0;
    });
  }

  // Function to save the steps count locally
  Future<void> _saveSteps(int steps) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('steps', steps);
  }

  // Function to load the steps count from local storage
  Future<void> _loadSteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      steps = prefs.getInt('steps') ?? 0;
    });
  }
}

