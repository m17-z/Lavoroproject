import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/widgets/buttom_bar.dart';
import '../widgets/emp_home_body.dart';

class EmpHomeView extends StatelessWidget {
  const EmpHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees Page ",
          style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w900,fontSize: 26)),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: const EmpHomeBody(),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 3, // Adjust the selectedIndex for EmpHomeView
        onTabChange: (index) {
          switch (index) {
            case 0:
              Get.toNamed('/home'); // Navigate to HomeView
              break;
            case 1:
              Get.toNamed('/JOBS');
              break;
            case 2:
              Get.toNamed('/user-profile'); // Navigate to UserProfileView page
              break;
            case 3:
              // Do nothing or handle the EmpHomeView tab as needed
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
