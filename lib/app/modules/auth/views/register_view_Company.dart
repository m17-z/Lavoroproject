// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lavoro/app/modules/auth/widgets/register_body_company.dart';

import '../../../global_widgets/loading_widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/Type.dart';

class RegisterViewCompany extends GetView<SignupController> {
  const RegisterViewCompany({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      isLoading: controller.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create Company Account',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 25),
          ),
          leading: IconButton(
            onPressed: () {
              Get.toNamed(Routes.SIGNIN);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: const RegisterBodyCompany(),
      ),
    );
  }
}
