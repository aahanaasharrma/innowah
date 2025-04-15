import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }


  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }


  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  Future<DocumentSnapshot> getUserProfile(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }


  Future<void> signOut() async {
    await _auth.signOut();
  }


  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception("An unknown error occurred.");}}


  User? get currentUser => _auth.currentUser;
}
