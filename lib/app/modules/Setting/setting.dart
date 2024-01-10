// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

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
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            Image.asset('assets/logo/setting.gif'),
            SizedBox(height: 24,),
            CustomButton(
              label: 'Edit Email',
              backgroundColor: Colors.purple,
              onPressed: () => showSnackbar('Edit Email'),
            ),
           
           
            SizedBox(height: 20),
            CustomButton(
              label: 'About Us',
              backgroundColor: Colors.purple,
              onPressed: () => showAboutUsDialog(context),
            ),
            SizedBox(height: 20),
            CustomButton(
              label: 'Log Out',
              backgroundColor: Colors.red, // Choose your preferred color
              onPressed: () => logOut(),
            ),
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

  void logOut() async {
    await Get.defaultDialog(
      title: "SignOut",
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 25),
          Text(
            "You're leaving\nAre you sure?",
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
        label: "Log Out",
        onPressed: () => AuthRepository.signOut(),
      ),
      cancel: CustomButton(
        label: "Cancel",
        onPressed: () => Get.back(),
      ),
    );
  }
}