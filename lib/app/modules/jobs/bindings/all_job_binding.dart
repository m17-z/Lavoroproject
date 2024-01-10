import 'package:get/get.dart';

import '../controller/all_job_controller.dart';


class AllJobsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllJobsController>(
      () => AllJobsController(),
    );
  }
}
