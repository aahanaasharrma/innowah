import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressReportPage extends StatefulWidget {
  final double carbonFootprint;

  const ProgressReportPage({Key? key, required this.carbonFootprint}) : super(key: key);

  @override
  _ProgressReportPageState createState() => _ProgressReportPageState();
}

class _ProgressReportPageState extends State<ProgressReportPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to get previous day's logs
  Future<List<Map<String, dynamic>>> _getPreviousLogs() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not authenticated");

    final todayStart = DateTime.now().subtract(Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute, seconds: DateTime.now().second, milliseconds: DateTime.now().millisecond, microseconds: DateTime.now().microsecond));
    final todayEnd = DateTime.now().add(Duration(days: 1)).subtract(Duration(milliseconds: 1));

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('activities')
        .where('date', isLessThan: Timestamp.fromDate(todayStart))
        .get();

    return snapshot.docs.map((doc) {
      final activity = doc.data();
      return {
        'date': activity['date'].toDate(),
        'carbonEmission': activity['carbonEmission'],
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double dailyGoal = 20.0;
    double progress = (widget.carbonFootprint / dailyGoal).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Footprint Report'),
        backgroundColor: Color(0xFFB0C7A6),
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
              progressColor: Color(0xFFB0C7A6),
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
              style: TextStyle(fontSize: 18, color: Color(0xFFB0C7A6)),
            ),
            const SizedBox(height: 30),
            Text(
              "Previous Logs:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _getPreviousLogs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No previous logs available.'));
                }

                final previousLogs = snapshot.data!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: previousLogs.length,
                    itemBuilder: (context, index) {
                      final log = previousLogs[index];
                      final date = log['date'] as DateTime;
                      final emission = log['carbonEmission'] as double;

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text("CO₂ Emission: ${emission.toStringAsFixed(2)} kg"),
                          subtitle: Text('Date: ${date.toLocal().toString().split(' ')[0]}'),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
