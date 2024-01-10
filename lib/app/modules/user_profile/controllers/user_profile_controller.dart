import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/data/model/user_model.dart';

class UserProfileController extends GetxController {

     final currentUser = UserAccount.info!;
   final formKey = GlobalKey<FormState>();
   RxBool isLoading = false.obs;
  late TextEditingController username;
  late TextEditingController description;
  late TextEditingController phoneNumber;
  final RxBool isExpanded = false.obs;
  String uuid = UserAccount.info!.uid;
  late String experience;
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

   void refreshPage() {
    update(); // Use GetX's update() function to trigger UI refresh
  }
  
  void onInit() {
    username = TextEditingController();
    description = TextEditingController();
    phoneNumber = TextEditingController();
  
    selectedLanguages = <String>[].obs;
    experience = experiences[0];
    // user = Get.arguments['user'];
    super.onInit();
  }

  Future<void> updateUserInFirestore({
    required String newUsername,
    required String newSelectedJobs,
    required String newPhoneNumber,
    required String newJobDescription,
    required List<String> newProgrammingLanguages,
 
    required String newExperience,
  }) async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final DocumentReference userRef = _firestore.collection('users').doc(uuid);

      await _firestore.runTransaction((transaction) async {
        final DocumentSnapshot snapshot = await transaction.get(userRef);

        if (snapshot.exists) {
          transaction.update(userRef, {
            'username': newUsername,
            'jobDescription': newJobDescription,
            'phoneNumber': newPhoneNumber,
            'Programing Language': newProgrammingLanguages,
         
            'selectedjobs': newSelectedJobs,
            'experience': newExperience,
          });
        }
      });

      update(); // Notify GetX that the data has been updated
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user account: $e');
      }
      rethrow; // Rethrow the exception to handle it in the calling code
    }
  }
}
