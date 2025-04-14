import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase_service.dart';
import 'carbon_calendar.dart';


class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final FirebaseService _firebaseService = FirebaseService();
  double _carbonFootprint = 0.0;

  final List<String> _activityTypes = [
    'Car Travel (km)',
    'Bike Travel (km)',
    'Bus Travel (km)',
    'Train Travel (km)',
    'Plant-Based Meal',
    'Meat-Based Meal',
    'Electricity Usage (kWh)',
    'Coal (kWh)',
    'Clothing Purchase',
    'Electronics Purchase',
    'Plastic Waste (kg)',
    'Recycled Materials (kg)',
  ];

  String? _selectedActivity;
  double _activityValue = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchTotalCarbonFootprint(); // Fetch total carbon footprint when page loads
  }

  void _fetchTotalCarbonFootprint() async {
    final activities = await _firebaseService.getActivities().first;
    double totalFootprint = 0.0;

    for (var activity in activities) {
      totalFootprint += activity.carbonEmission;
    }

    setState(() {
      _carbonFootprint = totalFootprint;
    });
  }

  void _logActivity() async {
    if (_selectedActivity == null || _activityValue == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an activity and enter a value')),
      );
      return;
    }

    double carbonEmission = calculateCarbon(_selectedActivity!, _activityValue);

    Activity newActivity = Activity(
      name: _selectedActivity!,
      carbonEmission: carbonEmission,
      date: DateTime.now(),
    );

    try {
      await _firebaseService.addActivity(newActivity);
      _fetchTotalCarbonFootprint(); // Refresh total footprint after logging activity

      setState(() {
        _selectedActivity = null;
        _activityValue = 0.0;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging activity: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0), // Make AppBar bigger
        child: AppBar(
          backgroundColor: Color(0xFFB0C7A6), // Light green background color
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0), // Adjust padding for better alignment
            child: Text(
              'Daily Journal',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), // Bigger text
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.show_chart, size: 30), // Slightly larger icon
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProgressReportPage(carbonFootprint: _carbonFootprint),
                  ),
                );
              },
            ),
          ],
          elevation: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Log Your Activity',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedActivity,
              items: _activityTypes.map((activity) {
                return DropdownMenuItem(
                  value: activity,
                  child: Text(activity),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedActivity = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Activity',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Enter Value (Distance in km, Meals, kWh, kg, etc.)',
              style: TextStyle(fontSize: 16),
            ),
            Slider(
              value: _activityValue,
              min: 0,
              max: 100,
              divisions: 100,
              label: _activityValue.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _activityValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logActivity,
              child: Text('Log Activity'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total Carbon Footprint: ${_carbonFootprint.toStringAsFixed(2)} kg CO2',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<Activity>>(
                stream: _firebaseService.getActivities(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final activities = snapshot.data!;
                    return ListView.builder(
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        final activity = activities[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(activity.name),
                            subtitle: Text(
                              'CO2: ${activity.carbonEmission.toStringAsFixed(2)} kg | Date: ${activity.date.toLocal().toString().split(' ')[0]}',
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


double calculateCarbon(String activityType, double value) {
  switch (activityType) {
    case 'Car Travel (km)':
      return value * 0.1325;
    case 'Bike Travel (km)':
      return 0;
    case 'Bus Travel (km)':
      return value * 0.1099;
    case 'Train Travel (km)':
      return value * 0.0845;

    case 'Plant-Based Meal':
      return value * 0.8;
    case 'Meat-Based Meal':
      return value * 6;

    case 'Electricity Usage (kWh)':
      return value * 0.92;
    case 'Coal (kWh)':
      return value * 1.0478;
    case 'Clothing Purchase':
      return value * 6.0;
    case 'Electronics Purchase':
      return value * 50.0;

    case 'Plastic Waste (kg)':
      return value * 2.6;
    case 'Recycled Materials (kg)':
      return value * -1.0;

    default:
      return 0.0;
  }
}


class Activity {
  String name;
  double carbonEmission;
  DateTime date;

  Activity({required this.name, required this.carbonEmission, required this.date});


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'carbonEmission': carbonEmission,
      'date': Timestamp.fromDate(date),
    };
  }


  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      name: map['name'] ?? '',
      carbonEmission: (map['carbonEmission'] as num).toDouble(),
      date: map['date'] is Timestamp ? (map['date'] as Timestamp).toDate() : DateTime.parse(map['date']),
    );
  }
}
