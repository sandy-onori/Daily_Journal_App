# Table of Contents

1. [Daily Journal App](#daily-journal-app)
2. [Download Apk Directly](#download-apk-directly)
3. [Features](#features) 
4. [Screenshots](#screenshots)
5. [Technologies Used](#technologies-used)
6. [Development Environment Setup](#development-environment-setup)
   - [Prerequisites](#prerequisites)
     - [Install Flutter](#1--install-flutter)
     - [Install Dart SDK](#2--install-dart-sdk)
     - [Install IDE or Code Editor](#3--install-ide-or-code-editor)
     - [Install Firebase CLI](#4--install-firebase-cli)
7. [Project Setup](#project-setup)
   - [Clone the Repository](#clone-the-repository)
   - [Install Dependencies](#for-installing-dependencies-run-the-following-command-to-fetch-all-dependencies-mentioned-in-the-pubspecyaml-file)
   - [Set Up Firebase](#set-up-firebase)
   - [Run the Application](#run-the-application-to-start-the-app-on-a-connected-device-or-emulator)
8. [Running Tests](#running-tests)


<h1>Daily Journal App</h1>

<p>The Daily Journal app is a Flutter application developed to help users record and manage their daily thoughts and experiences. This app utilizes Firebase, a cloud-based backend service, for user authentication and storage. The app consists of four main pages: authentication, home, create journal, and display journal.</p>


https://github.com/user-attachments/assets/1826e2a4-d5fa-4d7a-ac53-67faf7504d24

The video demonstration outlines the application flow and user interactions. Initially, users are presented with a **Landing Page**, which provides a brief introduction to the application. From there, they are redirected to the **Login Page**. For new users, a dedicated button at the bottom facilitates the account creation and authentication process.

Upon successful authentication, users are navigated to the **Home Screen**, which serves as the central hub for managing journal entries. On this screen, users can perform the following actions:  

- **Create a New Journal Entry:** Initiates the journal creation process.  
- **View Journal Entry Details:** Displays a detailed view of a selected journal entry, including additional actions.  
- **Logout:** Allows users to securely log out of the application.  

The **View Journal Screen** offers further options for managing the selected journal entry:  
- **Edit Button:** Enables modifications to the journal entry's content.  
- **Delete Button:** Allows users to permanently remove the journal entry from the database.  




<h2>Download Apk Directly</h2>
<p>Download the apk file from the GitHub repository and install it on your device.</p>
    
- [Apk Path! click here](./app-release.apk) 
error downloading? the apk is present in root directory of the repo

<h2>Features</h2>

<ul>
  <li><strong>Authentication Page:</strong> This page allows users to log in if they have an existing account or sign up if they are new users. It provides secure user authentication using Firebase Authentication.</li>
  <li><strong>Home Page:</strong> The home page displays a list of the user's journal entries and includes a drawer with simple user details and a sign-out button.</li>
  <li><strong>Create Journal Page:</strong> Users can create a new journal entry using a form provided on this page. The entries are stored in Firebase Firestore for future retrieval.</li>
  <li><strong>Display Journal Page:</strong> This page displays detailed information about a specific journal entry, including the date and content. Users can also delete a journal entry if needed.</li>
</ul>

<h2>Screenshots</h2>

<table>
  <tr>
    <th>Login Page</th>
    <th>Home Page</th>
    <th>Create Journal Page</th>
    <th>Display Journal Page</th>

  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/0206d1f9-986e-4f47-93c4-94928ef507b8" width="300" height="450" /></td>
    <td><img src="https://github.com/user-attachments/assets/1eefec8d-c9ab-42dc-8f52-fc2524718a78" width="300" height="450"/></td>
    <td><img src="https://github.com/user-attachments/assets/727886dd-bf01-47de-a16a-03280befcc38" width="300" height="450" /></td>
    <td><img src="https://github.com/user-attachments/assets/386e0f3e-7d91-4f71-bd04-99bbef2026ba" width="300" height="450" /></td>
  </tr>
</table>

<h2>Technologies Used</h2>

<ul>
  <li>Flutter: A cross-platform framework for developing mobile applications.</li>
  <li>Firebase Authentication: Provides user authentication, login, and sign-up functionality.</li>
  <li>Firebase Firestore: A NoSQL database for storing and managing journal entries.</li>
</ul>

# Development Environment Setup

## Prerequisites

### 1- Install Flutter

Ensure Flutter is installed on your system. Follow the [official Flutter installation guide](https://docs.flutter.dev/get-started/install) for your operating system.

```bash 
# Verify Flutter installation by running this command in terminal
flutter doctor
```

Make sure there are no unresolved issues before proceeding.

### 2- Install Dart SDK

Flutter comes bundled with the Dart SDK. Ensure it's properly installed by checking the Dart version:

```bash
dart --version
```

### 3- Install IDE or Code Editor

Use an IDE like Android Studio or Visual Studio Code with Flutter and Dart plugins.

### 4- Install Firebase CLI

Install the Firebase CLI to initialize Firebase in your project.

```bash
npm install -g firebase-tools
firebase login
```

# Project Setup

### Clone the Repository

```bash
git clone <repository-url>
cd flutter-Daily-journal-app
```

For Installing Dependencies Run the following command to fetch all dependencies mentioned in the pubspec.yaml file:
```bash
flutter pub get
```
### Set Up Firebase

Install the FlutterFire CLI to configure Firebase.
```bash
dart pub global activate flutterfire_cli
```
Initialize Firebase in the project:
```bash
flutterfire configure
```
This generates the firebase_options.dart file with platform-specific Firebase configurations.

### Run the Application To start the app on a connected device or emulator:
```bash
flutter run
```
# Running Tests

The project includes unit tests located in the `test` directory to ensure the functionality of CRUD operations for journal entries. These tests verify the app's behavior across various scenarios, including successful operations, edge cases, and error handling. Below is a summary of the tests included in this project:

## List of Tests

1. **Simple Add Journal Entry Test**  
   Verifies that a new journal entry is successfully added to the Firestore collection.

2. **Delete Journal Entry Test**  
   Checks that a journal entry can be deleted and ensures the Firestore collection is updated accordingly.

3. **Retrieve All Journal Entries Test**  
   Confirms that all existing journal entries are correctly retrieved from Firestore.

4. **Update Existing Journal Entry Test**  
   Validates that an existing journal entry's title and content can be updated.

5. **Add Journal Entry with Empty Title Test**  
   Ensures the application throws an error when trying to add an entry with an empty title.

6. **Update Non-Existent Journal Entry Test**  
   Tests the application's response when attempting to update an entry that does not exist.

7. **Delete Non-Existent Journal Entry Test**  
   Confirms that the application handles errors when trying to delete a non-existent entry.

8. **Add Journal Entry with Empty Content Test**  
   Verifies that journal entries with empty content can be added if the title is present.

9. **Retrieve Data When No Entries Exist Test**  
   Ensures the application handles an empty Firestore collection gracefully.

10. **Update Journal Entry with Empty Title Test**  
    Ensures the application throws an error when trying to update an entry with an empty title.

11. **Update Journal Entry with Empty Text Test**  
    Verifies that an entry's text can be updated to empty while preserving the title.

12. **Retrieve Journal Entries in Correct Order Test**  
    Confirms that journal entries are retrieved in the correct order based on their timestamps.

13. **Delete with Invalid Document ID Test**  
    Ensures the application handles errors gracefully when an invalid document ID is used for deletion.

## Running the Tests

To execute all unit tests in the project, use the following command in the terminal:  

```bash
flutter test
```  

These tests ensure that the app's core functionality performs reliably under various conditions.

This documentation should guide developers in setting up and running the project efficiently while adhering to best practices. For additional help, refer to the [official Flutter documentation](https://docs.flutter.dev/).
