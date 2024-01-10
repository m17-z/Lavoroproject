// ignore_for_file: file_names, unnecessary_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lavoro/app/modules/home/controllers/job_controller.dart';
import 'package:lavoro/app/modules/home/widgets/create_appbar.dart';
import 'package:lavoro/app/modules/home/widgets/job_body.dart';

class JobView extends GetView<CreateJobController> {
  const JobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CreateJobController());
    return const Scaffold(
      appBar: JobAppbar(),
      body: JobBody(),
    );
  }
}
