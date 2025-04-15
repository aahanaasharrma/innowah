import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Presentation/Screen/Daily_Journal/daily_log.dart';

class FirebaseService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

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
