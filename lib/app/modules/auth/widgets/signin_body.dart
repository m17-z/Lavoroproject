import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/data/model/user_model.dart';
import 'package:lavoro/app/modules/auth/forget_page/themehelper.dart';

import '../../../core/utils/validators.dart';

import '../../../global_widgets/custom_textformfield.dart';
import '../../../global_widgets/headar_widget.dart';
import '../../../global_widgets/loading_widget.dart';

import '../../../global_widgets/text_theme.dart';
import '../controllers/signin_controller.dart';

import '../forget_page/for.dart';

class SigninBody extends GetView<SigninController> {
  const SigninBody({Key? key}) : super(key: key);

  bool get isLoading => false;

  @override
  Widget build(BuildContext context) {
    Get.put(SigninController());

    if (kDebugMode) {
      print(UserAccount.info);
    }

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
                "assets/logo/Login.gif",
                height: 350,
              ),
            ),
            SafeArea(
              child: Container(
                margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "    Sign in to your account",
                      textAlign: TextAlign.center,
                      style: AppStyles.headLine1.copyWith(
                        color: Get.theme.colorScheme.onBackground,
                      ),
                    ),
                    SizedBox(height: Get.height * .02),
                    CustomTextFormField(
                      controller: controller.emailController,
                      prefixIcon: const Icon(Icons.email),
                      label: "Email",
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      validator: CustomValidator.validateEmail,
                      required: true,
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      controller: controller.passwordController,
                      prefixIcon: const Icon(Icons.lock),
                      label: "Password",
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: const [AutofillHints.password],
                      validator: CustomValidator.validatePassword,
                      required: true,
                    ),
                    const SizedBox(height: 13),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const Forget(),
                            transition: Transition.rightToLeftWithFade);
                      },
                      child: const Text(
                        "   Forgot Your Password ?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    Container(
                      decoration: ThemeHelper().buttonBoxDecoration(context),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                          backgroundColor: Get.theme.colorScheme.primary,
                          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        ),
                        onPressed: () {
                          controller.login(
                            controller.emailController.text,
                            controller.passwordController.text,
                          );
                          kThemeAnimationDuration;
                        },
                        child: Text(
                          "Sign In",
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.button.copyWith(
                            color: Get.theme.colorScheme.background,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        TextButton(
                          onPressed: controller.goToSignUpView,
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * .1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
