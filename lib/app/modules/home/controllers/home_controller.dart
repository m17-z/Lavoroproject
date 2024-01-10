// ignore_for_file: non_constant_identifier_names, avoid_print, use_rethrow_when_possible

import 'package:get/get.dart';
import 'package:lavoro/app/data/model/companyModel.dart';
import 'package:lavoro/app/data/model/job_model.dart';

import 'package:lavoro/app/data/repositorys/create_repository.dart';

class HomeController extends GetxController {
  int get bottomNavIndex => _bottomNavIndex;
  int _bottomNavIndex = 0;
  RxList<CreateJobAcount> allJobs = <CreateJobAcount>[].obs;
  CompanyModel? company;

  void changeIndex(int index) {
    _bottomNavIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // Replace getAllJobs with getAllJobsStream
    getAllJobsStream();
  }

  final JobRepo = Get.put(CreateJobRepositry());

  void getAllJobsStream() {
    JobRepo.getAllJobsStream().listen((jobs) {
      allJobs.assignAll(jobs);
      update();
    });
  }

  Future<CompanyModel> getcompany(String uuid) async {
    try {
      CompanyModel usercom = await JobRepo.getCompany(uuid);
      company = usercom;
      print(company);
      return usercom; // Return the usercom value
    } catch (error) {
      print("Error retrieving company: $error");
      throw error; // Re-throw the error to propagate it
    }
  }

  Future<void> getJob(String uuid) async {}
}
