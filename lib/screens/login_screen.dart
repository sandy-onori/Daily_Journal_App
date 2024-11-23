import 'package:daily_journal/screens/home_screen.dart';
import 'package:daily_journal/screens/signup_screen.dart';
import 'package:daily_journal/services/firebase_auth_methods.dart';
import 'package:daily_journal/utils/pallete.dart';
import 'package:daily_journal/widgets/custom_button.dart';
import 'package:daily_journal/widgets/login_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

/// A screen that allows users to log in to their account.
class LoginScreen extends StatelessWidget {
  /// Creates an instance of [LoginScreen].
  LoginScreen({super.key});

  /// Controller for the email input field.
  final TextEditingController emailController = TextEditingController();

  /// Controller for the password input field.
  final TextEditingController passwordController = TextEditingController();

  /// Disposes of the controllers when the widget is removed from the widget tree.
  void dipose() {
    emailController.dispose();
    passwordController.dispose();
  }

  /// Logs in the user with the provided email and password.
  ///
  /// Returns a [String] indicating the result of the login attempt.
  /// If successful, navigates to the [HomeScreen].
  void loginUser(BuildContext context) async {
    String res = await FirebaseAuthMethods(FirebaseAuth.instance)
        .signInWithEmail(
            email: emailController.text,
            password: passwordController.text,
            context: context);
    if (res == "success" && context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              const Text(
                "Sign in",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Pallete.dark,
                ),
              ),
              const SizedBox(height: 64),
              LoginField(
                hintText: 'Enter your Email',
                labelText: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 16),
              LoginField(
                hintText: 'Enter your Password',
                labelText: 'Password',
                controller: passwordController,
                isObscured: true,
              ),
              const SizedBox(height: 32),
              CustomButton(
                height: 50,
                text: 'Sign in',
                onPressed: () {
                  loginUser(context);
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => SignupScreen()),
                      ),
                    );
                  },
                  child: const Text(
                    "New Here? Sign Up!",
                    style: TextStyle(color: Pallete.darkHint),
                  )),
              const Spacer(),
            ],
          ),
        ),
      ),
    ));
  }
}
