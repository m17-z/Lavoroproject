import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/data/model/user_model.dart';

import '../../../data/provider/user_firebase.dart';
import '../../../routes/app_pages.dart';

class SigninController extends GetxController {
  RxBool isLoading = false.obs; // استخدام RxBool لحالة التحميل
  late TextEditingController emailController;
  late TextEditingController passwordController;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading(true); // تغيير حالة التحميل لتظهر التحميل أثناء عملية تسجيل الدخول

      await auth.signInWithEmailAndPassword(email: email, password: password);

      await DatabaseFirestore.getUser();

      // إظهار معلومات المستخدم إذا كانت مُفعلة Debug Mode
      if (kDebugMode) {
        print(UserAccount.info);
      }

      // انتقال المستخدم إلى الصفحة الرئيسية بعد تسجيل الدخول
      Get.offAllNamed(Routes.HOME);

    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Error Occurred During Login Please Try Again Later';

      // تحديد رسالة الخطأ استنادًا إلى نوع الخطأ
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid Email Address Please Enter A Valid Email';
          break;
        case 'user-disabled':
          errorMessage = 'This user account has been disabled';
          break;
        case 'user-not-found':
          errorMessage = 'User not found';
          break;
        case 'wrong-password':
          errorMessage = 'Invalid Email Or Password, Please Check Your Credentials';
          break;
        default:
          errorMessage = 'Error: ${e.message}';
      }

      // عرض الخطأ باستخدام GetX SnackBar
      Get.snackbar(
        "About Login".tr,
        "Login Message".tr,
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          'Login Failed'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        messageText: Text(
          errorMessage,
          style: const TextStyle(color: Colors.white),
        ),
      );

    } finally {
      isLoading(false); // إيقاف حالة التحميل بعد الانتهاء من عملية تسجيل الدخول
    }
  }

  void goToSignUpView() => Get.toNamed(Routes.SIGNUP);
}
