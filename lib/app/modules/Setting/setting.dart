// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/core/theme/app_theme.dart';

import '../../data/repositorys/auth_repository.dart';
import '../../global_widgets/custom_button.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF929EAA),
        title: Text('Settings'),
      ),
      backgroundColor: Color(0xFF929EAA),
      body: Padding(
        padding: EdgeInsets.all(Get.width * .1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/logo/setting.gif'),
            SizedBox(
              height: 24,
            ),
            CustomButton(
              label: 'Edit Email',
              icons: Icons.edit,
              backgroundColor: Colors.purple,
              onPressed: () => showSnackbar('Edit Email'),
            ),
            SizedBox(height: 20),
            CustomButton(
              label: 'About Us',
              icons: Icons.info,
              onPressed: () => showAboutUsDialog(context),
            ),
            SizedBox(height: 20),
            CustomButton(
              label: 'Delete Account',
              icons: Icons.delete,
              backgroundColor: Colors.red, // Choose your preferred color
              onPressed: () => delete(),
            )
          ],
        ),
      ),
    );
  }

  void showSnackbar(String message) {
    Get.snackbar(
      'Button Pressed',
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showAboutUsDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
            ),
            Text(
              'About Us',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 4.0),
            Text(
              'Lavoro is an app that aims to help individuals find suitable training and employment opportunities according to their qualifications and interests. This program offers a set of tools and features that facilitate the process of searching for jobs and training opportunities, and also makes it easier for companies to search for employees.',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void showMoodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Choose Mood'),
          children: [
            ListTile(
              leading: Icon(Icons.nightlight_round),
              title: Text('Night Mode'),
              onTap: () {
                Get.back();
                Get.changeTheme(AppTheme.dark);
                showSnackbar('Night Mode Selected');
              },
            ),
            ListTile(
              leading: Icon(Icons.wb_sunny_rounded),
              title: Text('Light Mode'),
              onTap: () {
                Get.back();
                Get.changeTheme(AppTheme.light);
                showSnackbar('Day Mode Selected');
              },
            ),
          ],
        );
      },
    );
  }

  void delete() async {
    await Get.defaultDialog(
      title: "Delete account",
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 25),
          Text(
            "You're Deleting\n your account are you sure?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
      confirm: CustomButton(
        backgroundColor: Colors.red,
        label: "Delete Account",
        onPressed: () async {
          await deleteAccountAndLogout();
          // Perform additional actions if needed after account deletion
        },
      ),
      cancel: CustomButton(
        label: "Cancel",
        onPressed: () => Get.back(),
      ),
    );
  }

  Future<void> deleteAccountAndLogout() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Delete user from Firestore collection
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();

        // Delete user from Firebase Authentication
        await user.delete();

        // Show dialog to confirm logout
        AuthRepository.signOut();
      }
    } catch (error) {
      print("Error deleting account: $error");
      // Handle error as needed
    }
  }
}
