import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Services/model.dart';

class InboxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: _buildInboxContent(),
    );
  }

  Widget _buildInboxContent() {
    return FutureBuilder<List<Ride>>(
      future: _fetchUserRides(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No rides booked yet.'));
        } else {
          List<Ride> rides = snapshot.data!;

          return ListView.builder(
            itemCount: rides.length,
            itemBuilder: (context, index) {
              Ride ride = rides[index];

              return ListTile(
                title: Text('${ride.departureLocation} to ${ride.destination}'),
                subtitle: Text('Booked by: ${ride.bookedBy}'),
                trailing: Icon(Icons.check_circle, color: Colors.green),
                onTap: () {
                  // Add action for ride tap (view details, etc.)
                },
              );
            },
          );
        }
      },
    );
  }

  // Fetch rides where the user is the publisher or the booked user
  Future<List<Ride>> _fetchUserRides() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('rides')
          .where('bookedBy', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) {
        return Ride.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Error fetching rides: $e');
      return [];
    }
  }
}
