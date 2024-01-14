// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/core/utils/helpers/system_helper.dart';
import 'package:lavoro/app/data/model/companyModel.dart';
import 'package:lavoro/app/data/model/user_model.dart';
import 'package:lavoro/app/modules/user_profile/widgets/custom_profile_listtile.dart';
import 'package:lavoro/app/modules/user_profile/widgets/job_post.dart';

import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/text_theme.dart';
import '../../../routes/app_pages.dart';
import '../controllers/user_profile_controller.dart';
import 'custom_header_widget.dart';

class UserProfileBody extends StatelessWidget {
  final UserProfileController _userProfileController = Get.find();

  final CompanyModel? company;
  final bool isnotuser;

  UserProfileBody({
    Key? key,
    required this.company,
    this.isnotuser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _userProfileController.refreshPage();

    final user = UserAccount.info!;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error',
          'User information not available.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      });

      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    List<String> selectedLanguages = user.selectedLanguage;
    print(user.username);
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      CustomHeaderWidget(
        isnotuser: isnotuser,
        useraccount: company,
      ),
      // const SizedBox(height: 20)

      CustomProfileListTile(
        label: user.username,
        icons: Icons.text_fields,
        showCopyButton: false,
      ),
      const SizedBox(height: 20),
      CustomProfileListTile(
        label: user.email,
        icons: Icons.email,
        showCopyButton: true,
      ),
      const SizedBox(height: 20),
      CustomProfileListTile(
        label: user.phoneNumber,
        icons: Icons.phone,
        onTap: () => SystemHelper.makeCall(user.phoneNumber),
      ),
      if (user.isCompany == false) const SizedBox(height: 20),
      if (user.isCompany == false)
        CustomProfileListTile(
          label: user.experience,
          icons: Icons.timer,
          showCopyButton: false,
        ),
      const SizedBox(height: 20),
      CustomProfileListTile(
        label: user.country,
        icons: Icons.location_city,
        showCopyButton: false,
      ),
      const SizedBox(height: 20),
      CustomProfileListTile(
        label: user.descrption,
        icons: Icons.description,
        showCopyButton: false,
      ),
      const SizedBox(height: 20),
      CustomProfileListTile(
        label: user.selectedjobs,
        icons: Icons.work,
        showCopyButton: false,
      ),

      // Displaying selected languages
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              'Programing Languages:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: isnotuser
                ? company!.selectedLanguage.length
                : selectedLanguages.length,
            itemBuilder: (context, index) {
              return CustomProfileListTile(
                label: isnotuser
                    ? company!.selectedLanguage[index]
                    : selectedLanguages[index],
                icons: Icons.language,
                showCopyButton: false,
                // Add other properties or actions if needed
              );
            },
          ),
          const SizedBox(
            height: 17,
          ),
          CustomButton(
            label: "Edit Information",
            icons: Icons.edit,
            onPressed: () async {
              await Get.toNamed(Routes.EDIT_INFO);
              // This code executes after the user navigates back from the editing page
              // You can add logic here to refresh the user profile page

              _userProfileController.update();
              // Call the refresh function after returning from the editing page
            },
          ),
          const SizedBox(
            height: 17,
          ),
          // Other CustomProfileListTile widgets...
          const Divider(
              color: Color.fromRGBO(0, 0, 0, 1), height: 12, thickness: 2),
          if (user.isCompany == true) ...[
            Text(
              "Your Posts  ",
              textAlign: TextAlign.center,
              style: AppStyles.headLine1.copyWith(
                color: Get.theme.colorScheme.onBackground,
              ),
            ),
            const Divider(color: Colors.black, height: 12, thickness: 2),
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('Jobs')
                  .where('companyId', isEqualTo: user.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No jobs available'));
                } else {
                  List<Map<String, dynamic>> jobs = snapshot.data!.docs
                      .map((doc) => doc.data() as Map<String, dynamic>)
                      .toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: jobs.length,
                    itemBuilder: (context, index) {
                      var job = jobs[index];
                      //var job = snapshot.data!.docs[index].id;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildJobCard(
                          job['Title'],
                          List<String>.from(job['Programing Language']),
                          job['experience'],
                          job['jobdescription'],
                          job['jobs'],
                          job['jobuid'],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
          // ... other widgets ...
        ],
      ),
    ]));
  }

  Widget _buildJobCard(
    String title,
    List<String> programmingLanguages,
    String experience,
    String jobdescription,
    String jobs,
    String jobId,
  ) {
    return Card(
      elevation: 110,
      margin: EdgeInsets.all(6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: const Color.fromARGB(255, 62, 58, 58),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              height: 2,
              endIndent: 2,
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 4),
            Text(
              'Name of job: $jobs',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              height: 2,
              endIndent: 2,
            ),
            const Text(
              'Programming Languages that need:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            // Display each programming language in a ListTile
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: programmingLanguages.map((language) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.language),
                  title: Text(language),
                );
              }).toList(),
            ),
            const Divider(
              height: 2,
              endIndent: 2,
            ),
            const SizedBox(height: 4),
            Text('Experience: $experience',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 4),

            Text('Job Description: $jobdescription',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                _deleteJob(jobId);
              },
              child: const Text('Delete Job'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteJob(String jobId) async {
    try {
      await FirebaseFirestore.instance.collection('Jobs').doc(jobId).delete();
      // Refresh the UI or perform any necessary updates
    } catch (e) {
      print('Error deleting job: $e');
      // Handle the error, if any
    }
  }
}
