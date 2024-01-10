import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/modules/emp_home/emp_category/cat_page.dart';
import 'package:lavoro/app/modules/home/controllers/job_controller.dart';

class EmpCatView extends StatelessWidget {
  final String categoryName;

  const EmpCatView({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CreateJobController()); // Ensure CreateJobController is initialized

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: EmpCategoryPage(
          categoryName: categoryName), // Pass the categoryName to CategoryPage
    );
  }
}
