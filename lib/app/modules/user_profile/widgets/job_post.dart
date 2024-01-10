import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobPosting extends StatelessWidget {
  final String userId;

  const JobPosting({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('Jobs')
          .where('companyId', isEqualTo: userId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No jobs Posted Yet'));
        } else {
          List<Map<String, dynamic>> jobs = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              var job = jobs[index];
              return _buildJobCard(
                job['Title'],
                List<String>.from(job['Programing Language']),
                job['experience'],
                job['jobdescription'],
                job['jobs'],
              );
            },
          );
        }
      },
    );
  }

  Widget _buildJobCard(
    String title,
    List<String> programmingLanguages,
    String experience,
    String jobdescription,
    String jobs,
  ) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
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
            const Divider(height: 2, endIndent: 2),
            const SizedBox(height: 8),
            Text('Name of job: $jobs', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Divider(height: 2, endIndent: 2),
            const Text(
              'Programming Languages that need:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
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
            const Divider(height: 2, endIndent: 2),
            const SizedBox(height: 4),
            Text('Experience: $experience', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Job Description: $jobdescription', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
