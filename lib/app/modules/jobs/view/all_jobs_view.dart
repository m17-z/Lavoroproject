// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lavoro/app/modules/jobs/widgets/all_jobs.dart';


import '../../../data/model/user_model.dart';
import '../../home/views/Job_view.dart';
import '../../home/widgets/buttom_bar.dart';

class AllJobsView extends StatelessWidget {
  const AllJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jobs Page',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
              fontSize: 26),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: const AllJobsBody(),
        floatingActionButton: UserAccount.info?.isCompany == true

          ? FloatingActionButton(
              onPressed: () {
                Get.to(const JobView());
              },
              tooltip: 'Add',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1, 
        onTabChange: (index) {
          switch (index) {
            case 0:
              Get.toNamed('/home'); 
              break;
            case 1:
            
              break;
            case 2:
              Get.toNamed('/user-profile');
              break;
            case 3:
              Get.toNamed('/emp_home'); 
              break;
            default:
             
              break;
          }
        },
      ),
    );
  }
}
