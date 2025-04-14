import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'daily_log.dart';


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

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('activities')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Activity.fromMap(doc.data())).toList());
  }
  Future<List<Activity>> getActivitiesOnce() async {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('activities')
        .get();

    return snapshot.docs.map((doc) => Activity.fromMap(doc.data())).toList();
  }

}
