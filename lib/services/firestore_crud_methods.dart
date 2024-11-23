import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_journal/utils/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

/// Class for CRUD operations with Firestore.
class CrudMethods {
  final FirebaseFirestore firestore; // Firestore instance.
  final FirebaseAuth auth; // FirebaseAuth instance.
  DateTime today = DateTime.now(); // Current date and time.

  /// Constructor to initialize Firestore and FirebaseAuth.
  CrudMethods(this.firestore, {FirebaseAuth? auth})
      : auth = auth ?? FirebaseAuth.instance;

  /// Adds a new journal entry to Firestore.
  Future<void> addData({
    required String title,
    required String data,
    required BuildContext context,
  }) async {
    if (title.isEmpty) {
      throw FirebaseException(
          plugin: 'Firestore', message: 'Title cannot be empty');
    }

    try {
      await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("journals")
          .add({
        'title': title,
        'text': data,
        'date':
            "${today.day}-${today.month}-${today.year}-${today.hour}:${today.minute}",
      });
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.message!); // Show error message.
      }
    }
  }

  /// Retrieves all journal entries for the current user.
  Stream<QuerySnapshot> getData() {
    return firestore
        .collection("users/${auth.currentUser?.uid}/journals")
        .orderBy('date', descending: true)
        .snapshots();
  }

  /// Updates an existing journal entry.
  Future<void> updateData({
    required String docId,
    required String title,
    required String text,
    required BuildContext context,
  }) async {
    if (title.isEmpty) {
      throw FirebaseException(
          plugin: 'Firestore', message: 'Title cannot be empty');
    }

    final docRef = firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("journals")
        .doc(docId);

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      throw FirebaseException(
          plugin: 'Firestore', message: 'Document does not exist');
    }

    try {
      await docRef.update({
        'title': title,
        'text': text,
      });
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.message!); // Show error message.
      }
    }
  }

  /// Deletes a journal entry.
  Future<void> delete({required String docId}) async {
    final docRef = firestore
        .collection("users/${auth.currentUser?.uid}/journals")
        .doc(docId);

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      throw FirebaseException(
          plugin: 'Firestore', message: 'Document does not exist');
    }

    await docRef.delete(); // Delete the document.
  }
}
