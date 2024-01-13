// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lavoro/app/modules/auth/controllers/varify_controller.dart';

// import '../../../global_widgets/loading_widget.dart';
// import '../../../routes/app_pages.dart';
// import '../controllers/email_var_controller.dart';
// import '../widgets/varify_body.dart';

// class VarifyView extends GetView<VerifyController > {
//   const VarifyView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LoadingWidget(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Verify account',
//             style: TextStyle(fontStyle: FontStyle.italic, fontSize: 25),
//           ),
//           leading: IconButton(
//           onPressed: () {
//             Get.toNamed(Routes.SIGNIN);
//           },
//           icon: const Icon(Icons.arrow_back_ios_new),
//         )),
//         body:  VerifyBody(), // No need for const here
//       ),  
//     );
//   }
// }
