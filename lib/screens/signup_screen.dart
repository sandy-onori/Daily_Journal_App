import 'package:daily_journal/screens/home_screen.dart';
import 'package:daily_journal/services/firebase_auth_methods.dart';
import 'package:daily_journal/utils/pallete.dart';
import 'package:daily_journal/utils/show_snackbar.dart';
import 'package:daily_journal/widgets/custom_button.dart';
import 'package:daily_journal/widgets/login_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

/// Sign up screen for a new user
/// It asks for details like username, email and password to create new user
class SignupScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  SignupScreen({super.key});

  void dipose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  /// Signs up the user with the provided credentials.
  ///
  /// Displays a snackbar message if the passwords do not match or if the email
  /// is already in use. Navigates to the [HomeScreen] on successful signup.
  void signUpUser(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      showSnackBar(context, 'Passwords do not match');
      return;
    }

    String res = await FirebaseAuthMethods(FirebaseAuth.instance)
        .signUpWithEmail(
            username: usernameController.text,
            email: emailController.text,
            password: passwordController.text,
            context: context);
    if (res == 'email-already-in-use' && context.mounted) {
      showSnackBar(context, 'Email already in use');
    } else if (res == "success" && context.mounted) {
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
                "Signup",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Pallete.dark,
                ),
              ),
              const SizedBox(height: 64),
              LoginField(
                hintText: 'Enter your Username',
                labelText: 'Username',
                controller: usernameController,
                isObscured: false,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 8),
              LoginField(
                hintText: 'Confirm Password',
                controller: confirmPasswordController,
                isObscured: true,
              ),
              const SizedBox(height: 32),
              CustomButton(
                height: 50,
                text: 'Signup',
                onPressed: () {
                  signUpUser(context);
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    ));
  }
}
