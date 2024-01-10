// ignore_for_file: unused_import, file_names, avoid_print, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../user_profile/view/user_profile_view.dart';

class CompanyInfo extends StatelessWidget {
  final String categoryName;
  final String skill;

  const CompanyInfo({
    Key? key,
    required this.categoryName,
    required this.skill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            text: '$categoryName ',
            style: const TextStyle(fontSize: 20),
            children: <TextSpan>[
              TextSpan(
                text: skill,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('users')
      .where('isCompany', isEqualTo: true)
      .where('selectedjobs', isEqualTo: categoryName)
      .where('Programing Language', arrayContains: skill)
      .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(child: Text('No data found'));
    } else {
      return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          var userData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
          print(userData); 
          return buildUserCard(userData);
        },
      );
    }
  },
),
    );
  }

  Widget buildUserCard(Map<String, dynamic>? userData) {
  if (userData == null || userData.isEmpty) {
    return const SizedBox(); // Return an empty container if userData is null or empty
  }

  String username = userData['username'];
  String country = userData['country'];
  String imageUrl = userData['imageUrl'];
  String phoneNumber = userData['phoneNumber'];
  String email = userData['email'];
   String jobDescrption = userData['jobDescrption'];// Use a default value if 'name' is null
 

  return Card(
      borderOnForeground: true,
      elevation: 100,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      username,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                        const SizedBox(height: 4),
                      Text(
                       email, 
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'City: ${country}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        phoneNumber,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
            thickness: 1,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              jobDescrption,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 1,
            color: Colors.black,
          ),
          const SizedBox(height: 8),
          const SizedBox(
            height: 12,
          ),
          const Divider(
            height: 0,
            thickness: 1,
            color: Colors.black,
          ),
        ],
      ),
    );
}
}
