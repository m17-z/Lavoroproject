// import 'package:email_auth/email_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_navigation/src/snackbar/snackbar.dart';
// import 'package:lavoro/app/modules/auth/views/register_view_Company.dart';
// import 'package:lavoro/app/modules/auth/views/register_view_Employee.dart';

// class SignupController extends GetxController {
//   static
//   bool employee = true; // Sample value, replace it with your logic
// }

// class VerifyController extends GetxController {
//   late TextEditingController emailController;
//   late TextEditingController otpController;
//   late EmailAuth emailAuth;
// late final String _finalEmail;

//   @override
//   void onInit() {
//     emailController = TextEditingController();
//     otpController = TextEditingController();
//     emailAuth = EmailAuth(sessionName: "Test Session");
//     _finalEmail = "";
//     super.onInit();
//   }
// void sendOTP() async {
//   if (emailController.text.isNotEmpty) {
//     try {
//       var res = await emailAuth.sendOtp(recipientMail: emailController.text);
//       if (res) {
//         Get.snackbar(
//           "OTP Sent",
//           "OTP has been sent to your email",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       } else {
//         if (kDebugMode) {
//           print("Error: OTP not sent"); // Print a generic error message
//         }
//         Get.snackbar("Error", "OTP not sent",
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error: $e"); // Print the caught exception
//       }
//       Get.snackbar("Error", "An error occurred",
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   } else {
//     Get.snackbar("Error", "Email is empty",
//         snackPosition: SnackPosition.BOTTOM);
//   }
// }



//   void verifyOTP() async {
//     var res = emailAuth.validateOtp(
//       recipientMail: emailController.text,
//       userOtp: otpController.text,
//     );

//     if (res) {
//       _finalEmail = emailController.text;
//       Get.snackbar(
//         "Success",
//         "OTP verified",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       SignupController signupController = Get.find();

//       if (signupController.employee == true) {
//         Get.off(() => const RegisterViewEmployee());
//       } else {
//         Get.off(() => const RegisterViewCompany());
//       }
//     } else {
//       Get.snackbar(
//         "Error",
//         "OTP not verified",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
// }




