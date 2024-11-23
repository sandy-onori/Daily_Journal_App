import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_journal/screens/edit_journal_screen.dart';
import 'package:daily_journal/utils/common_functions.dart';
import 'package:flutter/material.dart';
import '../utils/pallete.dart';
import '../widgets/delete_entry_dialog.dart';

/// A widget that displays a journal entry.
class DisplayJournal extends StatelessWidget {
  /// Creates a [DisplayJournal] widget.
  ///
  /// The [data] parameter is required and must not be null.
  final QueryDocumentSnapshot<Object?> data;
  const DisplayJournal({super.key, required this.data});

  @override

  /// Builds the UI for the journal entry.
  ///
  /// This method returns a [Scaffold] containing the journal entry details.
  Widget build(BuildContext context) {
    var dateInfo = convertDateToArray(data['date']);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Pallete.backgroundColor,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => EditJournal(data: data)),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DeleteEntryDialog(data: data);
                  },
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [
                        Text(dateInfo[0],
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: "Times New Roman",
                            )),
                        Text(
                          dateInfo[1],
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: "Times New Roman",
                          ),
                        ),
                        Text(
                          dateInfo[2],
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: "Times New Roman",
                          ),
                        ),
                      ]),
                      Text(dateInfo[3],
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: "Times New Roman",
                            color: Pallete.white2,
                          ))
                    ]),
                const SizedBox(height: 32),
                Text(
                  data['title'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: "poppins",
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width - 32,
                  height: MediaQuery.of(context).size.height - 300,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Pallete.white1,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(data['text'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "poppins",
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
