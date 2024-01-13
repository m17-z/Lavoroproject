// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controllers/email_var_controller.dart';

// class VerifyBody extends GetView<VerifyController> {
//   final auth = FirebaseAuth.instance;

//   VerifyBody() {
//     Get.put(VerifyController());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Image.asset(
//                   "assets/logo/Mail sent.gif",
//                   height: 350,
//                 ),
//               ),
//               const SizedBox(
//                 height: 60,
//                 child: Text(
//                   "Enter your Email to get a link to verify your account",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               ListView(
//                 shrinkWrap: true,
//                 children: [
//                   TextFormField(
//                     controller: controller.cemailController,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(
//                         Icons.mail,
//                       ),
//                       suffixIcon: IconButton(
//                         onPressed: () async {
//                           await controller.sendVerificationEmail();
//                         },
//                         icon: const Icon(
//                           Icons.send_rounded,
//                           color: Colors.teal,
//                         ),
//                       ),
//                       hintText: "Email Address",
//                       border: const OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20), // Add spacing between email and password fields
//                   TextFormField(
//                     controller: controller.passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(
//                         Icons.lock,
//                       ),
//                       hintText: "Password",
//                       border: const OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
