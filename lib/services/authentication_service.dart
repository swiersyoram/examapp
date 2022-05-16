import 'package:examapp/main.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          '/teacherdashboard', (Route<dynamic> route) => false);
      return "signed in";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "signed up";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
