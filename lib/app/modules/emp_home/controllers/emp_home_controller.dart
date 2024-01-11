// ignore_for_file: non_constant_identifier_names, avoid_print, use_rethrow_when_possible

import 'package:get/get.dart';
import 'package:lavoro/app/data/model/emp_model.dart';

import 'package:lavoro/app/data/model/user_model.dart'; // Import UserModel instead of UserAccount

import 'package:lavoro/app/data/repositorys/create_repository.dart';

class EmpHomeController extends GetxController {
  int get bottomNavIndex => _bottomNavIndex;
  int _bottomNavIndex = 3;
  RxList<UserModel> allusers = <UserModel>[].obs; // Change type to UserModel

  void changeIndex(int index) {
    _bottomNavIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
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
