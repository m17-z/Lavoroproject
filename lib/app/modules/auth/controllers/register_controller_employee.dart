// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/data/repositorys/user_repository.dart';

import '../../../core/utils/helpers/custom_snack_bar.dart';
import '../../../core/utils/helpers/system_helper.dart';
import '../../../data/model/user_model.dart';
import '../../../data/provider/firebase_image.dart';
import '../../../data/provider/user_firebase.dart';
import '../../../routes/app_pages.dart';

class RegisterControllerEmployee extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  late User? user;
  late RxString selectedCity = "select City".obs;

  final RxBool isExpanded = false.obs;
  late String country;
  late String experience;
  late TextEditingController employeeNameController;
  late TextEditingController emailController;
  late TextEditingController descriptionController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
    late RxList<String> selectedJobs = <String>[].obs;
   late RxString selectedExperience = "select experience".obs;
  List<String> experiences = [
   
    "Trainer ",
    "0-Experince ",
    "1-5 years",
    "5-10  years",
    "10-15",
    "15 OR more",
  ];
  List<String> countries = [
    
    "irbid",
    "aqaba",
    "zarqa",
    "amman",
    "ma'an",
    "balqa",
    "maraq",
    "tafilah",
    "madaba",
    "jerash",
    "ajloun",
    "karak"
  ];

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

  final UserRepo = Get.put(UserRepository());

  String? imagePath;


  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    employeeNameController = TextEditingController();
    descriptionController = TextEditingController();
    phoneController = TextEditingController();
      country = countries[0];
    selectedLanguages = <String>[].obs;
    experience = experiences[0];
    // user = Get.arguments['user'];
    super.onInit();
  }

  Future<void> signUp() async {
    if (passwordConfirmed()) {
      try {
        await onContinuePressed();
      } catch (e) {
        if (kDebugMode) {
          print('Error during sign up: $e');
        }
        CustomSnackBar.error(message: e.toString());
      }
    } else {
      if (kDebugMode) {
        print('Passwords do not match');
      }
      // Handle passwords not matching, e.g., show an error.
    }
  }

  bool passwordConfirmed() {
    return passwordController.text.trim() ==
        confirmPasswordController.text.trim();
  }

  static User? get userInfo {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> onContinuePressed() async {
    SystemHelper.closeKeyboard();
    final isValidForm = formKey.currentState!.validate();
    if (isValidForm == false) return;
    if (imagePath == null || imagePath!.isEmpty) {
      CustomSnackBar.warning(
        title: "Profile picture",
        message: "Please select a profile picture",
      );
      return;
    }

    isLoading(true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      var uid = userInfo?.uid;
      final imageUrl = await FirebaseImage.uploadUserImage(
        imagePath: imagePath!,
        uid: uid!,
      );
  // final currentTime = DateTime.now();
      UserAccount userAccount = UserAccount(
        uid: uid,
        username: employeeNameController.text,
        imageUrl: imageUrl!,
        phoneNumber: phoneController.text,
        descrption: descriptionController.text,
        email: emailController.text,
       country: selectedCity.value,
        selectedjobs: selectedJob.value,
       selectedLanguage: selectedLanguages,
      experience: selectedExperience.value,
        isCompany: false,
        //  creationTime: currentTime
      );

      await DatabaseFirestore.setUser(userAccount: userAccount);

      UserAccount.info = userAccount;

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      CustomSnackBar.error(message: e.toString());
    }

    isLoading(true);
  }

  Future<void> createUser(UserAccount user) async {
    await UserRepo.createUser(user);
  }
}
