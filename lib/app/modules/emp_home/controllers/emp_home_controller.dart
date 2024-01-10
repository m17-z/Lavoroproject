// ignore_for_file: non_constant_identifier_names, avoid_print, use_rethrow_when_possible

import 'package:get/get.dart';

import 'package:lavoro/app/data/model/user_model.dart';

import 'package:lavoro/app/data/repositorys/create_repository.dart';

class EmpHomeController extends GetxController {
  int get bottomNavIndex => _bottomNavIndex;
  int _bottomNavIndex = 3;
  RxList<UserAccount> allusers = <UserAccount>[].obs;
  
  void changeIndex(int index) {
    _bottomNavIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // Replace getAllJobs with getAllJobsStream
   getNonCompanyUsersStream();
  }

  final JobRepo = Get.put(CreateJobRepositry());

  void getNonCompanyUsersStream() {
    JobRepo.getNonCompanyUsersStream().listen((users) {
      allusers.assignAll(users);
      update();
    });
  }

}
