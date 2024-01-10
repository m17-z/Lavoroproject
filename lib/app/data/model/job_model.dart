// ignore_for_file: non_constant_identifier_names, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:lavoro/app/data/provider/user_firebase.dart';


class CreateJobAcount extends GetxController {
  final String jobdescription;
  final String companyId;
  final String experience;
  final List<String> selectedLanguage;
  final String selectedjobs;
  final String title;
  final String jobuid;
  
  CreateJobAcount({
    required this.companyId,
    required this.jobdescription,
    required this.experience,
    required this.selectedjobs,
    required this.title,
    required this.selectedLanguage,
    required this.jobuid,
      //  required DateTime creationTime,

  });
  static CreateJobAcount? info;

  static final Rx<CreateJobAcount?> _currentUser = Rx<CreateJobAcount?>(null);

  static CreateJobAcount? get currentUser => _currentUser.value;

  static set currentUser(CreateJobAcount? newUser) {
    _currentUser.value = newUser;
  }

  static const String _collection = "job";
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobdescription': jobdescription,
      'experience': experience,
      'jobs': selectedjobs,
      'Programing Language': selectedLanguage,
      'Title': title,
      'companyId': companyId,
      "jobuid": jobuid,
          // 'creationTime': DateTime.now()
    };
  }

  factory CreateJobAcount.formJson(Map<String, dynamic> json) {
    info = CreateJobAcount(
      title: json['Title'] ?? "title",
      jobuid: json['jobuid'] ?? "jobuid",
      companyId: json['companyId'] ?? "companyId",
      jobdescription: json['jobdescription'] ?? "jobDescrption",
      experience: json['experience'] ?? "experience",
      selectedLanguage: json['Programing Language'] != null
          ? List<String>.from(json['Programing Language'])
          : ["Null"],
      selectedjobs: json['jobs'] ?? "SelectedJobs",
      // creationTime: json['creationTime'] != null
      // ? DateTime.fromMillisecondsSinceEpoch(json['creationTime'])
      // : DateTime.now(),
    );
    

    return info!;
  }
  static void updateViewr(String thisid) async {
    try {
      DatabaseFirestore.incrementReviwed(thisid);
      // ignore: empty_catches
    } catch (e) {}
  }

  CreateJobAcount copyWith({
    String? jobuid,
    String? title,
    String? jobdescription,
    String? experience,
    List<String>? selectedLanguage,
    String? selectedjobs,
    String? companyId,
    DateTime? creationTime,
  }) {
    return CreateJobAcount(
      companyId: jobuid ?? this.companyId,
      title: title ?? this.title,
      jobdescription: jobdescription ?? this.jobdescription,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedjobs: selectedjobs ?? this.selectedjobs,
      experience: experience ?? this.experience,
      jobuid: jobuid ?? this.jobuid,
      // creationTime: DateTime.now()
    );
  }

  @override
  String toString() {
    return '''CreateJobAcount [] ( 
    jobdescription: $jobdescription, 
    experience: $experience, 
    selectedLanguage:$selectedLanguage,
    selectedjobs:$selectedjobs,
    title: $title 
    )''';
  }

  // Future<void> updateCurrentUser() async {
  //   try {
  //     currentUser = this;
  //     await _db.collection(_collection).doc("jobId").set(toMap());
  //     update();
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error updating user account: $e');
  //     }
  //   }
  // }
}
