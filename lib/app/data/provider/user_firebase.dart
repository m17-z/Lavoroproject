import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:lavoro/app/modules/auth/views/signin_view.dart';


import '../model/user_model.dart';

class DatabaseFirestore extends GetxController {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static User? get userInfo {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<UserAccount> getUser() async {
    Completer<UserAccount> completer = Completer<UserAccount>();

    Timer(const Duration(seconds: 7), () {
      if (!completer.isCompleted) {
        Get.offAll(() => const SigninView());
      }
    });

    try {
      final paths = await _db.collection("users").doc(userInfo?.uid).get();
      Map<String, dynamic> data = paths.data() ?? {};

      if (!completer.isCompleted) {
        completer.complete(UserAccount.formJson(data));
      }
    } catch (e) {
      if (!completer.isCompleted) {
        Get.offAll(() => const SigninView());
      }
    }

    return completer.future;
  }

  static Future<void> setUser({required UserAccount userAccount}) async {
    try {
      await _db
          .collection("users")
          .doc(userAccount.uid)
          .set(userAccount.toMap());
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }

      rethrow;
    }
  }

  static Future<void> updateUser({required UserAccount userAccount}) async {
    try {
      await _db
          .collection("users")
          .doc(userInfo?.uid)
          .update(userAccount.toMap());
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  static incrementReviwed(String thisuid) async {
    try {
      if (kDebugMode) {
        print("done");
      }
      await _db.collection('users').doc(thisuid).update({
        "reviewd": FieldValue.arrayUnion([userInfo!.uid])
      });
    } catch (e) {
      if (kDebugMode) {
        print(thisuid);
      }
      if (kDebugMode) {
        print('Error updating document: $e');
      }
    }
  }

  static Future<String?> uploadUserImage({
    required String imagePath,
    required String uuid,
  }) async {
    log('''
    -------------------------
    | path: $imagePath,     |
    | uuid: $uuid,          |
    -------------------------
    ''');

    try {
      File uploadFile = File(imagePath);

      final TaskSnapshot uploadTask = await FirebaseStorage.instance
          .ref('users/$uuid/profile_image')
          .putFile(uploadFile);

      final String downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      log('Error uploading user image: $e,\n $imagePath');
      return null;
    }
  }

}