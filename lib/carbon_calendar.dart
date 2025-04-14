import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
class ProgressReportPage extends StatefulWidget {
  final double carbonFootprint;

  const ProgressReportPage({Key? key, required this.carbonFootprint}) : super(key: key);

  @override
  _ProgressReportPageState createState() => _ProgressReportPageState();
}

class _ProgressReportPageState extends State<ProgressReportPage> {
  @override
  Widget build(BuildContext context) {
    double dailyGoal = 20.0;
    double progress = (widget.carbonFootprint / dailyGoal).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(


        title: const Text('Carbon Footprint Report'),
        backgroundColor:  Color(0xFFB0C7A6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Today's Log",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 15.0,
              percent: progress,
              center: Text(
                "${(progress * 100).toStringAsFixed(1)}%",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              progressColor:   Color(0xFFB0C7A6),
              backgroundColor: Colors.grey[300]!,
              animation: true,
            ),
            const SizedBox(height: 30),
            Text(
              "You have emitted ${widget.carbonFootprint} kg of CO₂ today.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              "Daily Limit: $dailyGoal kg of CO₂",
              style: TextStyle(fontSize: 18, color:  Color(0xFFB0C7A6),),
            ),
          ],
        ),
      ),
    );
  }
}
