import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/custom_button.dart';

import '../../../global_widgets/text_theme.dart';
import '../controllers/Type.dart';

class SignupBody extends GetView<SignupController> {
  const SignupBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/logo/type.gif",
                height: 350,
              ),
            ),
            Text(
              "Create account",
              textAlign: TextAlign.center,
              style: AppStyles.headLine1.copyWith(
                color: Get.theme.colorScheme.onBackground,
              ),
            ),
            SizedBox(height: Get.height * .033),
            CustomButton(
              label: "Company",
              onPressed: controller.onSignupComapny,
            ),
            SizedBox(height: Get.height * .02),
            CustomButton(
              label: "Employee",
              onPressed: controller.onSignupEmployee,
            ),
            SizedBox(height: Get.height * .02),
          ],
        ),
      ),
    );
  }
}
