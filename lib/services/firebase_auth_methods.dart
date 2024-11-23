import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:daily_journal/utils/show_snackbar.dart';

/// A class that handles Firebase authentication methods.
class FirebaseAuthMethods {
  final FirebaseAuth
      _auth; // Instance of FirebaseAuth to manage authentication.

  /// Constructor that initializes the FirebaseAuth instance.
  FirebaseAuthMethods(this._auth);

  /// A stream that provides the current authentication state of the user.
  Stream<User?> get authState => _auth.authStateChanges();

  /// Signs up a user with email and password.
  ///
  /// Takes the user's username, email, password, and the BuildContext for showing snack bars.
  /// Returns a string indicating the result of the sign-up process.
  Future<String> signUpWithEmail({
    required String username,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String res = "some error occurred"; // Default response in case of failure.
    try {
      // Attempt to create a new user with the provided email and password.
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After successful user creation, store the user's information in Firestore.
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential
              .user?.uid) // Use the user's unique ID as the document ID.
          .set({
        'username': username,
        'email': email,
      });

      res = "success"; // Update response to indicate success.
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication exceptions.
      if (e.code == 'email-already-in-use') {
        res = e.code; // Return the error code if the email is already in use.
      } else {
        // Show a snackbar with the error message for other exceptions.
        if (context.mounted) {
          showSnackBar(context, e.message!);
        }
      }
    }
    return res; // Return the result of the sign-up process.
  }

  /// Signs in a user with email and password.
  ///
  /// Takes the user's email, password, and the BuildContext for showing snack bars.
  /// Returns a string indicating the result of the sign-in process.
  Future<String> signInWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String res = "some error occurred"; // Default response in case of failure.
    try {
      // Attempt to sign in the user with the provided email and password.
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = "success"; // Update response to indicate success.
    } on FirebaseAuthException catch (e) {
      // Show a snackbar with the error message if sign-in fails.
      if (context.mounted) {
        showSnackBar(context, e.message!);
      }
    }
    return res; // Return the result of the sign-in process.
  }

  /// Signs out the currently authenticated user.
  Future<void> signOut() async {
    await _auth
        .signOut(); // Call the signOut method on the FirebaseAuth instance.
  }
}
