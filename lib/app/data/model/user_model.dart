// ignore_for_file: unused_import, unnecessary_this, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../provider/user_firebase.dart';

class UserAccount extends GetxController {
  static UserAccount? info;

  final String uid;
  final String username;
  final List<String> selectedLanguage;
  final String selectedjobs;
  final String email;
  late String imageUrl;
  final String phoneNumber;
  final String country;
  final String descrption;
  final String experience;
  final bool? isCompany;
  UserAccount({
    required this.uid,
    required this.username,
    required this.imageUrl,
    required this.phoneNumber,
    required this.descrption,
    required this.selectedLanguage,
    required this.selectedjobs,
    required this.email,
    required this.country,
    required this.experience,
    required this.isCompany,
    //  required DateTime creationTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uid,
      'username': username,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'jobDescrption': descrption,
      'email': email,
      'country': country,
      'Programing Language': selectedLanguage,
      'experience': experience,
      'selectedjobs': selectedjobs,
      'isCompany': isCompany ?? false,
      //  'creationTime': DateTime.now()
    };
  }

  factory UserAccount.formJson(Map<String, dynamic> json) {
    var userAccount = info = UserAccount(
      uid: json["uuid"] ?? "uuid",
      username: json['username'] ?? "UserName",
      imageUrl: json['imageUrl'] ?? "ImageUrl",
      phoneNumber: json['phoneNumber'] ?? "PhoneNumber",
      descrption: json['jobDescrption'] ?? "Dec",
      email: json['email'] ?? "Email",
      country: json['country'] ?? "Couuntry",
      selectedLanguage: json['Programing Language'] != null
          ? List<String>.from(json['Programing Language'])
          : ["Null"],
      selectedjobs: json['selectedjobs'] ?? "selectedjobs",
      experience: json['experience'] ?? "experience",
      isCompany: json['isCompany'] ?? false,
      //    creationTime: json['creationTime'] != null
      // ? DateTime.fromMillisecondsSinceEpoch(json['creationTime'])
      // : DateTime.now(),
    );
    return info!;
  }

  UserAccount copyWith({
    String? uid,
    String? username,
    String? email,
    String? imageUrl,
    String? phoneNumber,
    String? descrption,
    String? country,
    String? experience,
    String? selectedjobs,
    List<String>? selectedLanguage,
    // DateTime? creationTime,}
  }) {
    return UserAccount(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      descrption: descrption ?? this.descrption,
      email: email ?? this.email,
      country: country ?? this.country,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedjobs: selectedjobs ?? this.selectedjobs,
      experience: experience ?? this.experience,
      isCompany: isCompany ?? this.isCompany,
      // creationTime: DateTime.now(),
    );
  }

  @override
  String toString() {
    return '''UserAccount [] (
      uuid: $uid,
      username: $username,
      imageUrl: $imageUrl,
      phoneNumber: $phoneNumber,
      jobDescrption: $descrption,
      email: $email,
      countrey:$country,
   selectedLanguage:$selectedLanguage,
       selectedjobs:$selectedjobs
    experience:$experience,
    isCompany:$isCompany,
     
    )''';
  }

  Future<void> updateUserInFirestore(
      {required String newUsername,
      required String newSelectedJobs,
      required String newPhoneNumber,
      required String newJobDescription,
      required List<String> newProgrammingLanguages,
      required String newSelectedLanguage,
      required String newExperince}) async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final CollectionReference users = _firestore.collection('users');

      // Update the specific fields in the user's information
      await users.doc(uid).update({
        'username': newUsername,
        'jobDescrption': newJobDescription,
        'phoneNumber': newPhoneNumber,
        'Programing Language': newProgrammingLanguages,
        'selectedLanguage': newSelectedLanguage,
        'selectedjobs': newSelectedJobs,
        'experience': newExperince,
      });

      // Optionally, update the local user information if needed
      // For example:
      // this.username = newUsername;
      // this.descrption = newDescription;
      // this.selectedLanguage = newSelectedLanguage;
      // ...and so on

      update(); // Notify GetX that the data has been updated
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user account: $e');
      }
      rethrow; // Rethrow the exception to handle it in the calling code
    }
  }
  Future<void> updateIsVerify(bool? isEmailVerified) async {
    if (isEmailVerified != null) {
      try {
        printInfo(info: isEmailVerified.toString());

        DatabaseFirestore.updateIsVerify(isEmailVerified);
        isEmailVerified = isEmailVerified;
      } catch (e) {
        printError(info: e.toString());
      }
    }
  }
}
