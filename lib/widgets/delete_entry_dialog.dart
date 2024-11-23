import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/pallete.dart';
import '../services/firestore_crud_methods.dart';

/// A dialog that confirms the deletion of a journal entry.
class DeleteEntryDialog extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> data;

  const DeleteEntryDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Pallete.backgroundColor,
      title: const Text("Delete", style: TextStyle(color: Pallete.accent)),
      content: const Text("Do you really want to delete this entry?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child:
              const Text("Cancel", style: TextStyle(color: Pallete.darkHint)),
        ),
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Pallete.accent),
          onPressed: () {
            Navigator.pop(context);
            CrudMethods(FirebaseFirestore.instance).delete(docId: data.id);
            Navigator.pop(context);
          },
          child:
              const Text("Continue", style: TextStyle(color: Pallete.white2)),
        ),
      ],
    );
  }
}

