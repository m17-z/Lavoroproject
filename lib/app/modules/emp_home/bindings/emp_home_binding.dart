import 'package:get/get.dart';

import '../controllers/emp_home_controller.dart';

class EmpHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmpHomeController>(
      () => EmpHomeController(),
    );
  }
}
