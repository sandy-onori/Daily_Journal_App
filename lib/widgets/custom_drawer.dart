import 'package:daily_journal/utils/pallete.dart';
import 'package:daily_journal/screens/login_screen.dart';
import 'package:daily_journal/services/firebase_auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomDrawer extends StatelessWidget {
  final DocumentSnapshot userData;

  const CustomDrawer({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    // Extract user data from the DocumentSnapshot
    final data = userData.data() as Map<String, dynamic>;
    final String displayName = data['username'] ?? 'No Name';
    final String email = data['email'] ?? 'No Email';

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        backgroundColor: Pallete.backgroundColor,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: const DrawerHeader(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 32,
                  bottom: 16,
                ),
                decoration: BoxDecoration(color: Pallete.backgroundColor),
                child: Text(
                  "Menu",
                  style: TextStyle(color: Pallete.dark, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      const Icon(
                        Icons.person_rounded,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayName,
                              style: const TextStyle(
                                color: Pallete.dark,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              email,
                              style: const TextStyle(
                                color: Pallete.dark,
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),
                  GestureDetector(
                    onTap: () async {
                      await FirebaseAuthMethods(FirebaseAuth.instance)
                          .signOut();
                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      }
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          size: 32,
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Sign Out",
                          style: TextStyle(color: Pallete.dark, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

