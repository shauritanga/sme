import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authService = Provider<AuthService>((ref) {
  return AuthService();
});

enum AuthState { authenticated, unauthenticated, loading }

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream to listen for authentication state changes
  final authStateProvider = StreamProvider<AuthState>((ref) {
    return ref.watch(authService).authStateChanges();
  });

  // Get the current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Method to listen for authentication state changes
  Stream<AuthState> authStateChanges() {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser != null) {
        return AuthState.authenticated;
      } else {
        return AuthState.unauthenticated;
      }
    });
  }

  // Method for email/password sign-in
  Future<bool> signInWithEmailPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      //print("Error during sign in: $e");
      return false;
    }
  }

  // Method for sign-out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Method for creating a new user account
  Future<bool> signUpWithEmailPassword(Map<String, dynamic> data) async {
    String email = data['email'];
    String password = data['password'];
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user!.uid.isNotEmpty) {
        await _firestore.collection("users").add(data);
        await credential.user!.updateDisplayName(data['name']);
        // _firebaseAuth.verifyPhoneNumber(
        //     phoneNumber: data['phone'],
        //     verificationCompleted: (PhoneAuthCredential phone) async {
        //       await credential.user!.updatePhoneNumber(data['phone']);
        //     },
        //     verificationFailed: (e) {},
        //     codeSent: (code, index) {},
        //     codeAutoRetrievalTimeout: (code) {});
      }
      return true;
    } catch (e) {
      //print("Error during sign up: $e");
      return false;
    }
  }

  // Method to reset the password
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Method to check if the email is verified
  bool isEmailVerified() {
    final user = _firebaseAuth.currentUser;
    return user != null ? user.emailVerified : false;
  }

  // Method to send email verification
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
}
