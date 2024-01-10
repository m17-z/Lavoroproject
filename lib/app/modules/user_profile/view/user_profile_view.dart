// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/data/model/companyModel.dart';
import 'package:lavoro/app/data/model/user_model.dart';

import '../../home/widgets/buttom_bar.dart';
import '../widgets/user_profile_body.dart';

class UserProfileView extends StatelessWidget {
  CompanyModel? company;
  bool isnotuser;
  UserProfileView({
    Key? key,
    this.company,
    required this.isnotuser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User profile',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
              fontSize: 26),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: UserProfileBody(company: null,),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2, // Adjust the selectedIndex for UserProfileView
        onTabChange: ( index) {
          switch (index) {
            case 0:
              Get.toNamed('/home'); // Navigate to HomeView
              break;
            case 1:
              Get.toNamed('/JOBS'); // Navigate to ChatUser page
              break;
            case 2:
              // Do nothing or handle the UserProfileView tab as needed
              break;
            case 3:
              Get.toNamed('/emp_home'); // Navigate to EmpHomeView page
              break;
            default:
              // Handle default case or do nothing
              break;
          }
        },
      ),
    );
  }
}
