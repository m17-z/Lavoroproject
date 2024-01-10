// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/modules/home/controllers/home_controller.dart';
import 'package:lavoro/app/modules/home/controllers/job_controller.dart';
import '../../../data/model/user_model.dart';
import '../../../global_widgets/custom_drawer.dart';
// Make sure to import the BottomNavBar widget
import '../widgets/buttom_bar.dart';
import '../widgets/home_appbar.dart';
import '../widgets/home_body.dart';
import 'Job_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const HomeAppBar(),
      body:  const HomeBody(),
       
          
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        onTabChange: (index) {
          switch (index) {
            case 0:
              // Do nothing or handle the Home tab as needed
              break;
            case 1:
              Get.toNamed('/JOBS'); // Navigate to ChatUser page
              break;
            case 2:
              Get.toNamed('/user-profile'); // Navigate to UserProfileView page
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
