import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Presentation/Screen/Daily_Journal/daily_log.dart';
import 'model.dart';

class FirebaseService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<String> _getUserEmail(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        // Safely retrieve the email, provide a default value if null
        return userDoc['email'] ?? 'Unknown';
      } else {
        return 'Unknown';
      }
    } catch (e) {
      print('Error fetching user email: $e');
      return 'Unknown';
    }
  }

  Future<void> addActivity(Activity activity) async {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('activities')
        .add(activity.toMap());
  }

  Stream<List<Activity>> getActivities() {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    final todayStart = DateTime.now().subtract(Duration(
      hours: DateTime.now().hour,
      minutes: DateTime.now().minute,
      seconds: DateTime.now().second,
      milliseconds: DateTime.now().millisecond,
      microseconds: DateTime.now().microsecond,
    ));
    final todayEnd = DateTime.now().add(Duration(days: 1)).subtract(Duration(milliseconds: 1));

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('activities')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(todayEnd))
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Activity.fromMap(doc.data(), doc.id)).toList());
  }

  Future<List<Activity>> getActivitiesOnce() async {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('activities')
        .get();

    return snapshot.docs.map((doc) => Activity.fromMap(doc.data(), doc.id)).toList();
  }

  // Delete Activity by ID
  Future<void> deleteActivity(String activityId) async {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('activities')
          .doc(activityId)
          .delete();
    } catch (e) {
      throw Exception("Error deleting activity: $e");
    }
  }
  Future<List<Ride>> getPublishedRides() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('rides')
          .where('status', isEqualTo: 'Published')
          .where('bookedBy', isNull: true) // Exclude booked rides
          .get();

      return snapshot.docs.map((doc) {
        return Ride(
          id: doc.id,
          departureLocation: doc['departureLocation'],
          destination: doc['destination'],
          departureTime: (doc['departureTime'] as Timestamp).toDate(),
          status: doc['status'],
          matched: doc['matched'],
          bookedBy: doc['bookedBy'],

        );
      }).toList();
    } catch (e) {
      print('Error getting published rides: $e');
      return [];
    }
  }

  Future<void> publishRide(Ride ride) async {
    try {
      final rideRef = FirebaseFirestore.instance.collection('rides').doc();

      // Store the ride with departureTime as a Firestore Timestamp
      await rideRef.set({
        'departureLocation': ride.departureLocation,
        'destination': ride.destination,
        'departureTime': Timestamp.fromDate(ride.departureTime), // Convert DateTime to Firestore Timestamp
        'status': ride.status,
        'matched': ride.matched,
        'bookedBy': ride.bookedBy,
        'userId': FirebaseAuth.instance.currentUser!.uid, // Store the publisher's UID
        'publishedAt': Timestamp.now(), // Store the time the ride was published
      });

      print('Ride published successfully');
    } catch (e) {
      print('Error publishing ride: $e');
    }
  }


  // Match rides based on destination and time
  Future<void> matchRides(Ride publishedRide) async {
  // Look for other rides with similar destination and departure time
  final matchingRidesQuery = _firestore
      .collection('rides')
      .where('destination', isEqualTo: publishedRide.destination)
      .where('departureTime', isGreaterThanOrEqualTo: publishedRide.departureTime.subtract(Duration(minutes: 30)))
      .where('departureTime', isLessThanOrEqualTo: publishedRide.departureTime.add(Duration(minutes: 30)))
      .where('matched', isEqualTo: false)  // Ensure the ride is not already matched
      .where('status', isEqualTo: 'Published');  // Only published rides

  final matchingRidesSnapshot = await matchingRidesQuery.get();

  // If matching rides are found, update them to be matched
  if (matchingRidesSnapshot.docs.isNotEmpty) {
  for (var doc in matchingRidesSnapshot.docs) {
  // Update both the published ride and the matched ride to indicate they are matched
  await _firestore.collection('rides').doc(publishedRide.id).update({'matched': true});
  await _firestore.collection('rides').doc(doc.id).update({'matched': true});
  }
  }}


  Future<void> bookRide(String rideId, String userId) async {
    await _firestore.collection('rides').doc(rideId).update({
      'status': 'Booked',
      'bookedBy': FirebaseAuth.instance.currentUser!.uid,
    });


  }
  Future<Map<String, dynamic>?> getUserDetails(String userId) async {
    try {
      DocumentSnapshot userDoc = await _db.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      } else {
        return null; // If the document does not exist
      }
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
  }



}

class Activity {
  String id; // Add id to keep track of the document's unique ID
  String name;
  double carbonEmission;
  DateTime date;

  Activity({
    required this.id, // Add id in the constructor
    required this.name,
    required this.carbonEmission,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'carbonEmission': carbonEmission,
      'date': Timestamp.fromDate(date),
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map, String id) {
    return Activity(
      id: id, // Pass the document ID here
      name: map['name'] ?? '',
      carbonEmission: (map['carbonEmission'] as num).toDouble(),
      date: map['date'] is Timestamp ? (map['date'] as Timestamp).toDate() : DateTime.parse(map['date']),
    );
  }

}
