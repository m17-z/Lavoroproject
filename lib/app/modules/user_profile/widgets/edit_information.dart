import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/validators.dart';
import '../../../data/model/user_model.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_textformfield.dart';
import '../controllers/user_profile_controller.dart';

class EditProfileInformation extends GetView<UserProfileController> {
  const EditProfileInformation({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    Get.put(UserProfileController());
    final currentUser = UserAccount.info!;

    // Initialize initial values
    String initialName = currentUser.username;
    String initialPhone = currentUser.phoneNumber;
    String initialDescription = currentUser.descrption;
    String initialjob = currentUser.selectedjobs;
    List<String> initiallang = currentUser.selectedLanguage;
    String initialexp = currentUser.experience;

    // Assign initial values to controller text fields
    controller.username.text = initialName;
    controller.phoneNumber.text = initialPhone;
    controller.description.text = initialDescription;
    controller.selectedJob.value= initialjob;
    controller.selectedExperience.value= initialexp;

controller.selectedLanguages = RxList<String>.from(initiallang);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Information"),
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 16.0),

                    const SizedBox(height: 16.0),
                  CustomTextFormField(
                    controller: controller.username,
                    prefixIcon: const Icon(Icons.person),
                  ),
             const SizedBox(height: 16),
                  CustomTextFormField(
                  
                    controller: controller.description,
                    prefixIcon: const Icon(Icons.description),
                  ),
                   const SizedBox(height: 16),
                   CustomTextFormField(
                  controller: controller.phoneNumber,
                    prefixIcon: const Icon(Icons.phone),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple),
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.black12,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Jobs:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19)),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            itemCount: controller.jobs.length,
                            itemBuilder: (context, index) {
                              final job = controller.jobs[index];
                              printInfo(info: job);
                              return Obx(
                                () {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.selectedJob.value = job;
                                      controller.selectedLanguages
                                          .addAll(controller.languages[job]!);
                                      controller.selectedLanguages.retainWhere(
                                        (language) =>
                                            controller.isSelected[language] ??
                                            false,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: controller.selectedJob == job
                                              ? const Color.fromARGB(
                                                  255, 1, 26, 46)
                                              : Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 16.0),
                                        child: Text(
                                          job,
                                          style: TextStyle(
                                            color: controller.selectedJob == job
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple),
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.black12,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Programming Languages:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19)),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            itemCount: controller
                                    .languages[controller.selectedJob]
                                    ?.length ??
                                0,
                            itemBuilder: (context, index) {
                              var language = controller
                                  .languages[controller.selectedJob]![index];
                              return Obx(() {
                                return GestureDetector(
                                  onTap: () {
                                    var language = controller.languages[
                                        controller.selectedJob]![index];

                                    // Toggle the selected state
                                    controller.addToSelectedLanguages(language);
                             
                                      print(controller.selectedLanguages);
                             
                                      print(controller.selectedLanguages
                                        .contains(language));
                                    
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: controller.selectedLanguages
                                                .contains(language)
                                            ? Colors.purple
                                            : Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 16.0),
                                      child: Text(
                                        language,
                                        style: TextStyle(
                                          color: controller.selectedLanguages
                                                  .contains(language)
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                 if (currentUser.isCompany == false)
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Select Experience:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
      ),
      const SizedBox(height: 8.0),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey,
        ),
        padding: const EdgeInsets.all(4.0),
        child: DropdownButton<String>(
          hint: const Text('Select Experience'),
          value: controller.selectedExperience.value.isNotEmpty &&
                  controller.experiences.contains(controller.selectedExperience.value)
              ? controller.selectedExperience.value
              : null,
          onChanged: (String? value) {
            controller.selectedExperience.value = value ?? '';
          },
          items: controller.experiences.map((String experience) {
            return DropdownMenuItem<String>(
              value: experience,
              child: Text(experience),
            );
          }).toList(),
        ),
      ),
    ],
  ),
                      const SizedBox(height: 16),
             CustomButton(
  label: "Save",
  onPressed: () {
    String updatedName = controller.username.text;
    String updatedDescription = controller.description.text;
    String updatedPhone = controller.phoneNumber.text;
    String updatedjobs = controller.selectedJob.value;
    String updatedexperience = controller.selectedExperience.value;
    List<String> updatedlanguges = controller.selectedLanguages;

    // Check if any field is empty
    if (updatedName.isEmpty ||
        updatedDescription.isEmpty ||
        updatedPhone.isEmpty ||
        updatedjobs.isEmpty ||
        updatedexperience.isEmpty ||
        updatedlanguges.isEmpty) {
      // Show red Snackbar and error message for empty fields
      Get.snackbar(
        'Error',
        'Please fill all fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // All fields are filled, proceed with the action
      controller.updateUserInFirestore(
        newUsername: updatedName,
        newPhoneNumber: updatedPhone,
        newJobDescription: updatedDescription,
        newSelectedJobs: updatedjobs,
        newProgrammingLanguages: updatedlanguges,
        newExperience: updatedexperience,
      );

      // Show green success Snackbar and navigate back after a successful save
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        onTap: (_) => Get.back(),
      );
    }
  },
),

                const SizedBox(height: 16),
                  const SizedBox(height: 16),
            ],
          ),
        ),
      )));
 
  
  }
}