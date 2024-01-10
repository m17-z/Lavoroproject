// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/data/model/companyModel.dart';
import 'package:lavoro/app/data/model/user_model.dart';

import '../model/job_model.dart';

// Make sure to import the correct model

class CreateJobRepositry extends GetxController {
  static CreateJobRepositry get instance => Get.find();
  final _firestore = FirebaseFirestore.instance;

  Future<void> createUser(CreateJobAcount createJob) async {
    try {
      await _firestore
          .collection("Jobs")
          .doc(createJob.jobuid)
          .set(createJob.toMap());
      Get.snackbar(
        "Success",
        "Job details have been added",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to add job details: $error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  Stream<List<CreateJobAcount>> getAllJobsStream() {
    return _firestore.collection("Jobs").snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CreateJobAcount.formJson(doc.data()))
          .toList();
    });
  }
    Stream<List<UserAccount>> getNonCompanyUsersStream() {
  return _firestore.collection("users").snapshots().map((snapshot) {
    return snapshot.docs
        .where((doc) => !(doc.data()['isCompany'] ?? false))
        .map((doc) => UserAccount.formJson(doc.data()))
        .toList();
  });
}

  Future<CompanyModel> getCompany(String uuid) async {
    try {
      print(CompanyModel.info);
      final CollectionReference comColliction =
          FirebaseFirestore.instance.collection('users');
      QuerySnapshot querySnapshot =
          await comColliction.where("uuid", isEqualTo: uuid).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDocumentSnapshot = querySnapshot.docs.first;

        Map<String, dynamic> userData =
            userDocumentSnapshot.data() as Map<String, dynamic>;

        CompanyModel company = CompanyModel.formJson(userData);
        print(UserAccount.info);
        return company;
      } else {
        // Handle the case where no document matches the condition
        print("No document with UUID $uuid found");
        return CompanyModel(
          uid: "uid",
          username: 'username',
          imageUrl: 'imageUrl',
          phoneNumber: 'phoneNumber',
          descrption: 'description',
          selectedLanguage: [''],
          selectedjobs: 'selectedjobs',
          email: 'email',
          country: 'country',
          experience: 'experience',
          isCompany: false,
        );
      }
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to retrieve user: $error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      rethrow;
    }
  }
}
