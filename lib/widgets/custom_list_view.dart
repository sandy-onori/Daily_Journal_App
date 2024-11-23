import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_journal/screens/display_journal_screen.dart';
import 'package:daily_journal/services/firestore_crud_methods.dart';
import 'package:daily_journal/utils/common_functions.dart';
import 'package:daily_journal/utils/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// List component to show all the fetched journal entries of the current user
class CustomListView extends StatefulWidget {
  const CustomListView({super.key});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  final currentUser =
      FirebaseAuth.instance.currentUser; // Current user instance

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: CrudMethods(FirebaseFirestore.instance)
          .getData(), // Stream of journal data
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child:
                CircularProgressIndicator(), // Loading indicator while fetching data
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:
                    snapshot.data!.docs.length, // Number of journal entries
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?> journal =
                      snapshot.data!.docs[index]; // Current journal entry
                  return CustomTile(
                    entryData: journal, // Pass journal entry to CustomTile
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class CustomTile extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> entryData; // Journal entry data
  const CustomTile({super.key, required this.entryData});

  @override
  Widget build(BuildContext context) {
    var dateInfo =
        convertDateToArray(entryData['date']); // Convert date to array format
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => DisplayJournal(
                        data:
                            entryData, // Navigate to DisplayJournal with entry data
                      )),
                ),
              );
            },
            child: SizedBox(
                width: double.infinity,
                child: Card(
                  color: Pallete.white1, // Card background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // Rounded corners for the card
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 8), // Padding inside the card
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${dateInfo[1]} ${dateInfo[2]}, ${dateInfo[0].substring(0, 3)}", // Formatted date
                                style: const TextStyle(
                                  fontSize: 12,
                                  color:
                                      Pallete.darkHint, // Text color for date
                                ),
                              ),
                              Text(
                                dateInfo[3], // Time of the journal entry
                                style: const TextStyle(
                                  fontSize: 12,
                                  color:
                                      Pallete.darkHint, // Text color for time
                                ),
                              )
                            ]),
                        const SizedBox(height: 8),
                        Text(
                          entryData['title'], // Title of the journal entry
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600, // Bold title
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entryData['text'].length > 100
                              ? '${entryData['text'].substring(0, 100)}...' // Truncate text if too long
                              : entryData['text'], // Full text if short enough
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))),
        const SizedBox(height: 16), // Space between journal entries
      ],
    );
  }
}
