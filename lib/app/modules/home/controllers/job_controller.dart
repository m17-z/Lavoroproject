// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/model/job_model.dart';
import '../../../data/repositorys/create_repository.dart';

class CreateJobController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  late String experience;
  late TextEditingController jobDescriptionController;
  late TextEditingController titleController;
  late RxList<String> selectedJobs = <String>[].obs;

  late RxString selectedExperience = "select experience".obs;
  List<String> experiences = [
    "select experience",
    "0-Experience",
    "1-5 years",
    "5-10 years",
    "10-15",
    "15 OR more",
  ];
  // RxString selectedjob = 'Web Developer'.obs;

  RxList<String> selectedLanguages = <String>[].obs;
  final List<String> jobs = [
    'Web Developer',
    'Mobile App Developer',
    'Software Engineer',
    'Data Scientist',
    'Network Engineer',
    'Cybersecurity Analyst',
    'Database Administrator',
    'System Administrator',
    'AI Developer',
    'DevOps Engineer',
  ];

  final Map<String, List<String>> languages = {
    'Web Developer': ['HTML', 'JavaScript', 'PHP', 'Python', 'Ruby', 'Java', 'C#'],
    'Mobile App Developer': ['Swift', 'Kotlin', 'React-Native', 'Flutter','Java'],
    'Software Engineer': ['Python', 'Java', 'C++', 'C#', 'JavaScript'],
    'Data Scientist': ['Pandas', 'NumPy', 'Scikit-Learn', 'R', 'SQL', 'Scala'],
    'Network Engineer': ['Cisco-IOS', 'Python', 'PowerShell'],
    'Cybersecurity Analyst': ['Python', 'C++', 'Java', 'PowerShell', 'Bash-Scripting'],
    'Database Administrator': ['SQL', 'Oracle', 'MySQL', 'MongoDB'],
    'System Administrator': ['Linux-Shell-Scripting', 'PowerShell', 'Python','Unix-Shell-Scripting'],
    'AI Developer': ['TensorFlow', 'PyTorch', 'R', 'Java'],
    'DevOps Engineer': ['Linux-Shell-Scripting','Unix-Shell-Scripting', 'Ansible', 'Docker', 'Kubernetes'],
    'Game Developer': ['C++', 'C#', 'Unity', 'Unreal Engine', 'JavaScript', 'Python'],
  };
  RxMap<String, bool> isSelected = <String, bool>{}.obs;
  RxList<String> selectedlang = <String>[].obs;

  void addToSelectedLanguages(String language) {
    if (selectedLanguages.contains(language)) {
      selectedLanguages.remove(language);
    } else {
      selectedLanguages.add(language);
    }
  }

  // void addToSelectedLanguages(String language) {
  //   setState(() {
  //     isSelected[language] = !(isSelected[language] ?? false);
  //     if (isSelected[language]!) {
  //       selectedLanguages.add(language);
  //     } else {
  //       selectedLanguages.remove(language);
  //     }
  //   });
  // }

  void retainSelectedLanguages(Map<String, bool> isSelected) {
    selectedLanguages.retainWhere(
      (language) => isSelected[language] ?? false,
    );
  }

  // Assume you have a selected job variable
  RxString selectedJob = 'Web Developer'.obs;

  void selectJob(String job) {
    selectedJob.value = job;
    selectedLanguages.clear();
    selectedLanguages.addAll(languages[job]!);
  }

  // ignore: non_constant_identifier_names
  final UserRepo = Get.put(CreateJobRepositry());
  var uuid = const Uuid();

  @override
  void onInit() {
    titleController = TextEditingController();
    jobDescriptionController = TextEditingController();
    selectedJobs = <String>[].obs;
    experience = experiences[0];
    super.onInit();
  }

  User? get userInfo {
    return FirebaseAuth.instance.currentUser;
  }
 final currentTime = DateTime.now();
  Future<void> createUser() async {
    CreateJobAcount createJobAccount = CreateJobAcount(
      jobdescription: jobDescriptionController.text,
      title: titleController.text,
      selectedjobs: selectedJob.value,
      selectedLanguage: selectedLanguages,
      experience: selectedExperience.value,
      companyId: userInfo!.uid,
      jobuid: uuid.v4(),
      // creationTime: currentTime
    );
    print(createJobAccount);
    await UserRepo.createUser(createJobAccount);
  }

  void saveJobDetails() {
    createUser();
    // Assuming you want to do something else after creating the user
    // Implement your logic here
  }
}
