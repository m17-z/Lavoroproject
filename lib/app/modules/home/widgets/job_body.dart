// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/modules/home/controllers/job_controller.dart';


import '../../../global_widgets/custom_textformfield.dart';
import '../../../global_widgets/text_theme.dart';
import '../../auth/forget_page/themehelper.dart';

class JobBody extends GetView<CreateJobController> {
  const JobBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CreateJobController());
    return Scaffold(
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: "Job Title",
                    controller: controller.titleController,
                    prefixIcon: Icon(Icons.work),
                  ),
                  const SizedBox(height: 8.0),
                  CustomTextFormField(
                    label: "Job Discription",
                    controller: controller.jobDescriptionController,
                    prefixIcon: Icon(Icons.description),
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
                                    if (kDebugMode) {
                                      print(controller.selectedLanguages);
                                    }
                                    if (kDebugMode) {
                                      print(controller.selectedLanguages
                                        .contains(language));
                                    }
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
                          color: Colors.grey[300],
                        ),
                        padding: EdgeInsets.all(4.0),
                        child: DropdownButton<String>(
                          hint: const Text(
                              '                                                      Select Experience'),
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
                  Container(
                    decoration: ThemeHelper().buttonBoxDecoration(context),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                        backgroundColor: Get.theme.colorScheme.primary,
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      ),
                      onPressed: () {
                        controller.createUser();
                      },
                      child: Text(
                        "Create ",
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.button.copyWith(
                          color: Get.theme.colorScheme.background,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
