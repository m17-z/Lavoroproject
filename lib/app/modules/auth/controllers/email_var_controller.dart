// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lavoro/app/core/utils/helpers/custom_snack_bar.dart';
// import 'package:lavoro/app/routes/app_pages.dart';

// class VerifyController extends GetxController {
//   late TextEditingController cemailController;
//   late TextEditingController passwordController;

//   @override
//   void onInit() {
//     super.onInit();
//     cemailController = TextEditingController();
//     passwordController = TextEditingController();
//   }

//   Future<void> sendVerificationEmail() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       String email = cemailController.text;
//       String password = passwordController.text;

//       if (user == null) {
//         // Creating a new user with email and password
//         UserCredential userCredential =
//             await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         );

//         // Sending verification email
//         await userCredential.user?.sendEmailVerification();

//         // Printing the correct email
//         print('Verification email sent to $email');

//         // Showing the dialog
//         Get.defaultDialog(
//           title: 'Verification Email Sent',
//           middleText:
//               'A verification email has been sent to $email. Please check your email and click on the verification link to complete the registration process.',
//           textConfirm: 'OK',
//           onConfirm: () => Get.back(),
//         );
//       } else {
//         CustomSnackBar.error(message: 'User already exists');
//       }
//     } catch (e) {
//       print('Error sending verification email: $e');
//       CustomSnackBar.error(message: 'Error sending verification email');
//     }
//   }

//   Future<void> checkEmailVerification() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     try {
//       await user?.reload();
//       if (user!.emailVerified) {
//         Get.offNamed(Routes.RegisterEmplyee);
//       } else {
//         Get.defaultDialog(
//           title: 'Email Not Verified',
//           middleText:
//               'Your email is not verified. Please check your email for a verification link and click on it to complete the registration process.',
//           textConfirm: 'OK',
//           onConfirm: () => handleEmailVerification(),
//         );
//       }
//     } catch (e) {
//       print('Error checking email verification: $e');
//     }
//   }

//   Future<void> handleEmailVerification() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     try {
//       await user?.reload();
//       print(
//           'User email: ${user?.email}, Email verified: ${user?.emailVerified}');

//       if (user != null && user.emailVerified) {
//         print('Navigating to Routes.RegisterEmplyee');
//         Get.offNamed(Routes.RegisterEmplyee);
//       }
//     } catch (e) {
//       print('Error handling email verification: $e');
//     }
//   }
// }
