import 'package:flutter/material.dart';
import 'package:innowah/Services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import to fetch userId
import '../../../../Services/model.dart';

class SearchRidesPage extends StatefulWidget {
  @override
  _SearchRidesPageState createState() => _SearchRidesPageState();
}

class _SearchRidesPageState extends State<SearchRidesPage> {
  late Future<List<Ride>> _publishedRides;
  final firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _publishedRides = firebaseService.getPublishedRides();
  }

  // Show publisher details in pop-up
  void _showPublisherDetails(BuildContext context, Ride ride) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Publisher Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: John Doe'),  // Hardcoded details
              Text('Phone: 123-456-7890'),
              Text('Car Number: TN01AB1234'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog

                // Get the current user ID from Firebase Authentication
                String userId = FirebaseAuth.instance.currentUser!.uid;

                // Book the ride (change status to "booked")
                await firebaseService.bookRide(ride.id, userId);

                // Refresh the ride list
                setState(() {
                  _publishedRides = firebaseService.getPublishedRides();
                });

                // Show confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ride booked successfully!')),
                );
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Rides'),
      ),
      body: FutureBuilder<List<Ride>>(
        future: _publishedRides,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No available rides.'));
          } else {
            List<Ride> rides = snapshot.data!;
            return ListView.builder(
              itemCount: rides.length,
              itemBuilder: (context, index) {
                Ride ride = rides[index];
                return Card(
                  margin: EdgeInsets.all(12),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${ride.departureLocation} → ${ride.destination}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text('Date & Time: ${ride.departureTime.toLocal()}'),
                        SizedBox(height: 12),
                        ElevatedButton.icon(
                          icon: Icon(Icons.directions_car),
                          label: Text('Book Ride'),
                          onPressed: () => _showPublisherDetails(context, ride),  // Show publisher info
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
