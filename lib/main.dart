import 'package:daily_journal/firebase_options.dart';
import 'package:daily_journal/screens/home_screen.dart';
import 'package:daily_journal/screens/landing_screen.dart';
import 'package:daily_journal/services/firebase_auth_methods.dart';
import 'package:daily_journal/utils/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
            create: (_) => FirebaseAuthMethods(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null),
      ],
      child: MaterialApp(
        title: 'Daily Journal',
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Pallete.backgroundColor,
            textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Inter')),
        home: const AuthWrapper(),
      ),
    );
  }
}

/// Wraps Authentication Logic over the whole application
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const HomeScreen();
    } else {
      return const LandingScreen();
    }
  }
}
