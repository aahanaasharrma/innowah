import 'package:cloud_firestore/cloud_firestore.dart';

class Ride {
  String id;
  String departureLocation;
  String destination;
  DateTime departureTime;  // Use DateTime for the departure time
  String status;
  bool matched;
  String? bookedBy;
  DateTime? publishedAt; // Store when the ride was published

  Ride({
    required this.id,
    required this.departureLocation,
    required this.destination,
    required this.departureTime,
    required this.status,
    required this.matched,
    this.bookedBy,
    this.publishedAt,
  });

  // Convert Firestore document to Ride object
  factory Ride.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;

    // Convert the 'departureTime' and 'publishedAt' from Timestamp to DateTime
    return Ride(
      id: doc.id,
      departureLocation: data['departureLocation'] ?? '',
      destination: data['destination'] ?? '',
      departureTime: (data['departureTime'] as Timestamp).toDate(),  // Convert Timestamp to DateTime
      status: data['status'] ?? '',
      matched: data['matched'] ?? false,
      bookedBy: data['bookedBy'],
      publishedAt: data['publishedAt'] != null
          ? (data['publishedAt'] as Timestamp).toDate() // Convert Timestamp to DateTime
          : null,
    );
  }
}
