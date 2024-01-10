// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, avoid_print, unrelated_type_equality_checks
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../../core/utils/helpers/custom_bottom_sheet.dart';

import '../../../core/utils/validators.dart';

import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_textformfield.dart';
import '../controllers/register_controller_employee.dart';

class RegisterBodyEmployee extends GetView<RegisterControllerEmployee> {
  const RegisterBodyEmployee({super.key});

  @override
  Widget build(BuildContext context) {
      Get.put(RegisterControllerEmployee());
    return Scaffold(
       body: Obx(() => Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: Get.height * .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PickUserImageWidget(
                    onChanged: (imagePath) => controller.imagePath = imagePath,
                  ),
                ],
              ),
              CustomTextFormField(
                controller: controller.employeeNameController,
                label: 'Name',
                prefixIcon: const Icon(Icons.person),
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                controller: controller.emailController,
                label: 'Email',
                autofillHints: const [AutofillHints.email],
                prefixIcon: const Icon(Icons.email),
                validator: CustomValidator.validateEmail,
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                controller: controller.descriptionController,
                label: 'Description about your experiences',
                prefixIcon: const Icon(Icons.description),
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
                                            ? const Color.fromARGB(
                                                255, 1, 26, 46)
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Select Experience:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19)),
                      const SizedBox(height: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple),
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey,
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: DropdownButton<String>(
                          hint: const Text(
                              '                                                  Select Experience'
                              ,style: TextStyle(color: Colors.black)),
                          value:
                              controller.selectedExperience.value.isNotEmpty &&
                                      controller.experiences.contains(
                                          controller.selectedExperience.value)
                                  ? controller.selectedExperience.value
                                  : null,
                          onChanged: (String? value) {
                            controller.selectedExperience.value = value ?? '';
                          },
                          items:
                              controller.experiences.map((String experience) {
                            return DropdownMenuItem<String>(
                              value: experience,
                              child: Text(experience),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
  const SizedBox(height: 20),
  
              Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Select City:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19)),
                      const SizedBox(height: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple),
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey,
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: DropdownButton<String>(
                          hint: const Text(
                              '                                                                Select City'
                              ,style: TextStyle(color: Colors.black)),
                          value:
                              controller.selectedCity.value.isNotEmpty &&
                                      controller.countries.contains(
                                          controller.selectedCity.value)
                                  ? controller.selectedCity.value
                                  : null,
                          onChanged: (String? value) {
                            controller.selectedCity.value = value ?? '';
                          },
                          items:
                              controller.countries.map((String countries) {
                            return DropdownMenuItem<String>(
                              value: countries,
                              child: Text(countries),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.phoneController,
                label: 'Phone Number',
                prefixIcon: const Icon(Icons.phone),
                keyboardType: TextInputType.phone,
                validator: CustomValidator.validatePhoneNumber,
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                controller: controller.passwordController,
                label: 'Password',
                prefixIcon: const Icon(Icons.lock),
                isPassword: true,
                validator: CustomValidator.validatePassword,
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                controller: controller.confirmPasswordController,
                label: 'Confirm Password',
                prefixIcon: const Icon(Icons.lock),
                isPassword: true,
                validator: (value) => CustomValidator.confirmPassword(
                    value, controller.passwordController.text),
              ),
              const SizedBox(height: 16.0),
               CustomButton(
  onPressed: () async {
    if (controller.formKey.currentState!.validate() ||
        (controller.selectedLanguages.isNotEmpty &&
            controller.selectedJobs.isNotEmpty &&
            controller.selectedCity.isNotEmpty&&controller.selectedExperience.isNotEmpty)) {
      // All required fields are filled
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            backgroundColor: Colors.green,
            content: Row(
              children: [
                Icon(Icons.info, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'sucsses ',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      );

      // Call your function
      await controller.signUp();
    } else {
      // Please fill in all required fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill in all required fields',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
  label: 'SignUp',
),
            ],
          ),
        ),
      ),
    )));
  }
}

class PickUserImageWidget extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  const PickUserImageWidget({super.key, this.onChanged});

  @override
  State<PickUserImageWidget> createState() => _PickUserImageWidgetState();
}

class _PickUserImageWidgetState extends State<PickUserImageWidget> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            height: 125,
            width: 125,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                width: 5,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: ClipRRect(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: BorderRadius.circular(150),
              child: image?.path != null
                  ? Image.file(
                      File(image!.path),
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.person, size: 100),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              height: 40,
              width: 29,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: GestureDetector(
                onTap: () async {
                  final res = await CustomBottomSheet.imagePiker();
                  if (res != null) {
                    setState(() => image = res);
                    widget.onChanged?.call(res.path);
                  }
                },
                child: const Icon(
                  Icons.add_circle,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
