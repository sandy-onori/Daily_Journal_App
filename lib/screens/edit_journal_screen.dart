import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_journal/screens/home_screen.dart';
import '../services/firestore_crud_methods.dart';
import '../widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../utils/pallete.dart';

/// A screen for editing journal entries.
class EditJournal extends StatelessWidget {
  /// Creates an instance of [EditJournal].
  ///
  /// Requires a [data] parameter which contains the journal entry data.
  final TextEditingController dataController;
  final TextEditingController titleController;
  final QueryDocumentSnapshot<Object?> data;

  EditJournal({super.key, required this.data})
      : dataController = TextEditingController(text: data['text']),
        titleController = TextEditingController(text: data['title']);

  /// Updates the journal entry in Firestore.
  ///
  /// Takes the [docId] of the document to update, the new [title],
  /// the updated [data], and the [context] for navigation.
  void updateData(
      String docId, String title, String data, BuildContext context) async {
    await CrudMethods(FirebaseFirestore.instance)
        .updateData(docId: docId, title: title, text: data, context: context);
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var docId = data.id;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        actions: [
          GestureDetector(
            onTap: () {
              updateData(
                  docId, titleController.text, dataController.text, context);
            },
            child: const Padding(
                padding: EdgeInsets.all(16),
                child: Icon(Icons.save_rounded, size: 32)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              CustomTextField(
                  controller: titleController,
                  hintText: "Title/Quote for the day",
                  maxLines: 2),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: dataController,
                  hintText: "How was your day?",
                  maxLines: 20)
            ],
          ),
        ),
      ),
    );
  }
}
