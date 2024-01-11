class UserModel {
  final String uid;
  final String username;
  final List<String> selectedLanguage;
  final String selectedJobs;
  final String email;
  late String imageUrl;
  final String phoneNumber;
  final String country;
  final String description;
  final String experience;
  final bool? isCompany;

  UserModel({
    required this.uid,
    required this.username,
    required this.selectedLanguage,
    required this.selectedJobs,
    required this.email,
    required this.imageUrl,
    required this.phoneNumber,
    required this.country,
    required this.description,
    required this.experience,
    required this.isCompany,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uuid"] ?? "uuid",
      username: json['username'] ?? "UserName",
      imageUrl: json['imageUrl'] ?? "ImageUrl",
      phoneNumber: json['phoneNumber'] ?? "PhoneNumber",
      description: json['jobDescrption'] ?? "Dec",
      email: json['email'] ?? "Email",
      country: json['country'] ?? "Couuntry",
      selectedLanguage: json['Programing Language'] != null
          ? List<String>.from(json['Programing Language'])
          : ["Null"],
      selectedJobs: json['selectedjobs'] ?? "selectedjobs",
      experience: json['experience'] ?? "experience",
      isCompany: json['isCompany'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uid,
      'username': username,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'jobDescrption': description,
      'email': email,
      'country': country,
      'Programing Language': selectedLanguage,
      'experience': experience,
      'selectedjobs': selectedJobs,
      'isCompany': isCompany,
    };
  }

  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? imageUrl,
    String? phoneNumber,
    String? description,
    String? country,
    String? experience,
    String? selectedJobs,
    List<String>? selectedLanguage,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      description: description ?? this.description,
      email: email ?? this.email,
      country: country ?? this.country,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedJobs: selectedJobs ?? this.selectedJobs,
      experience: experience ?? this.experience,
      isCompany: isCompany ?? isCompany,
    );
  }

  @override
  String toString() {
    return '''UserModel [] (
      uuid: $uid,
      username: $username,
      imageUrl: $imageUrl,
      phoneNumber: $phoneNumber,
      jobDescrption: $description,
      email: $email,
      countrey: $country,
      selectedLanguage: $selectedLanguage,
      selectedjobs: $selectedJobs
      experience: $experience,
      isCompany: $isCompany,
    )''';
  }
}
