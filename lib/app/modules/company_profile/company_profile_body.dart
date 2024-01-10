// ignore_for_file: unnecessary_cast, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/core/utils/helpers/system_helper.dart';
import 'package:lavoro/app/data/model/companyModel.dart';
import 'package:lavoro/app/modules/company_profile/list_company_profile.dart';
import '../../data/model/user_model.dart';
import '../user_profile/widgets/custom_header_widget.dart';

class CompanyProfile extends StatelessWidget {
  CompanyModel? company;
  bool isnotuser;

  CompanyProfile({
    Key? key,
    this.company,
    this.isnotuser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = UserAccount.info;
    if (user == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
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

    return SingleChildScrollView(
        child: Column(children: <Widget>[
      CustomHeaderWidget(
        isnotuser: isnotuser,
        useraccount: company,
      ),
      CustomCompanyProfileListTile(
        label: isnotuser ? company!.username : user.username,
        icons: Icons.text_fields,
        showCopyButton: false,
      ),
      CustomCompanyProfileListTile(
        label: isnotuser ? company!.email : user.email,
        icons: Icons.email,
        showCopyButton: true,
      ),
      CustomCompanyProfileListTile(
        label: isnotuser ? company!.phoneNumber : user.phoneNumber,
        icons: Icons.phone,
        onTap: () => SystemHelper.makeCall(user.phoneNumber),
      ),
      CustomCompanyProfileListTile(
        label: isnotuser ? company!.country : user.country,
        icons: Icons.location_city,
        showCopyButton: false,
      ),
      CustomCompanyProfileListTile(
        label: isnotuser ? company!.descrption : user.descrption,
        icons: Icons.description,
        showCopyButton: false,
      ),
      CustomCompanyProfileListTile(
        label: isnotuser ? company!.country : user.country,
        icons: Icons.location_city,
        showCopyButton: false,
      ),
      CustomCompanyProfileListTile(
        label: isnotuser ? company!.selectedjobs : user.selectedjobs,
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
              return CustomCompanyProfileListTile(
                label: isnotuser
                    ? company!.selectedLanguage[index]
                    : selectedLanguages[index],
                icons: Icons.language,
                showCopyButton: false,
                // Add other properties or actions if needed
              );
            },
          ),
          // Other widgets...

          Divider(
            color: Colors.black,
            height: 12,
            thickness: 2,
          ),
          const Text(
            " posts that the company published",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.black,
            height: 12,
            thickness: 2,
          ),
          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('Jobs')
                .where('companyId', isEqualTo: company!.uid)
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildJobCard(
                        job['Title'],
                        List<String>.from(job['Programing Language']),
                        job['experience'],
                        job['jobdescription'],
                        job['jobs'],
                      ),
                    );
                  },
                );
              }
            },
          ),
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
            )
          ],
        ),
      ),
    );
  }
}
