import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:http/http.dart' as http;
import 'package:taskhero/calendar_client.dart';
import 'package:taskhero/google_client.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [cal.CalendarApi.calendarScope],
  );

  Future<http.Client?> getAuthenticatedClient() async {
    try {
      final account = await _googleSignIn.signIn();
      final auth = await account?.authentication;

      if (auth == null) return null;

      final client = GoogleHttpClient(auth.accessToken!);
      return client;
    } catch (e) {
      return null;
    }
  }

  Future<void> initializeCalendar() async {
    final client = await getAuthenticatedClient();

    if (client == null) {
      throw Exception('Failed to get authenticated client');
    }

    try {
      CalendarClient.calendar = cal.CalendarApi(client);
      debugPrint("Google Calendar API initialized successfully");
    } catch (e) {
      debugPrint("Error initializing calendar: $e");
    }
  }

  Future<bool> signInWithGoogle() async {
    final signIn = GoogleSignIn();
    final user = await signIn.signIn();
    final GoogleSignInAuthentication userAuth = await user!.authentication;
    var credential = GoogleAuthProvider.credential(
      idToken: userAuth.idToken,
      accessToken: userAuth.accessToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
