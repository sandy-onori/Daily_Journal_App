import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_journal/screens/create_journal_screen.dart';
import 'package:daily_journal/utils/pallete.dart';
import 'package:daily_journal/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_list_view.dart';

/// A screen that displays the home interface of the application.
class HomeScreen extends StatefulWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// The state for [HomeScreen].
class _HomeScreenState extends State<HomeScreen> {
  /// A future that holds the user data fetched from Firestore.
  late Future<DocumentSnapshot> userData;

  @override
  void initState() {
    super.initState();
    userData = fetchUserData();
  }

  /// Fetches the user data from Firestore.
  ///
  /// Throws an exception if the user is not logged in.
  Future<DocumentSnapshot> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    } else {
      throw Exception("User not logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Pallete.backgroundColor,
          title: const Text("Home",
              style: TextStyle(
                  color: Pallete.dark,
                  fontSize: 24,
                  fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        drawer: Builder(
          builder: (context) => FutureBuilder<DocumentSnapshot>(
            future: userData,
            builder: (context, snapshot) {
              // Check if the connection is still waiting for data
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Drawer(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              // Check if there was an error fetching the data
              else if (snapshot.hasError) {
                return Drawer(
                  child: Center(child: Text("Error: ${snapshot.error}")),
                );
              }
              // Check if the data does not exist
              else if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Drawer(
                  child: Center(
                      child: Text("No Entries Yet!!",
                          style: TextStyle(color: Pallete.darkHint))),
                );
              }
              // Pass the actual data to CustomDrawer
              return CustomDrawer(userData: snapshot.data!);
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: FloatingActionButton(
                backgroundColor: Pallete.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateJournal()));
                },
                child: const Icon(
                  Icons.edit,
                  color: Pallete.white2,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
              height: 80,
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: const CustomListView(),
        ));
  }
}
