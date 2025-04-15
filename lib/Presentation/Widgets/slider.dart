
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Daily Eco Points',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFB0C7A6), // Sage green color
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                '0', // Start of slider
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFB0C7A6), // Sage green color
                ),
              ),
              Expanded(
                child: Slider(
                  value: 62.5, // Halfway through the slider
                  min: 0,
                  max: 125, // End of slider
                  onChanged: (value) {
                    // Handle slider value change
                  },
                  activeColor: Color(0xFFB0C7A6), // Sage green color
                ),
              ),
              Text(
                '125', // End of slider
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFB0C7A6), // Sage green color
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
