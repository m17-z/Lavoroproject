// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/modules/home/category/categorypage.dart';
import 'package:lavoro/app/modules/home/controllers/job_controller.dart';

class CatView extends StatelessWidget {
  final String categoryName;

  const CatView({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CreateJobController()); // Ensure CreateJobController is initialized

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: CategoryPage(
          categoryName: categoryName), // Pass the categoryName to CategoryPage
    );
  }
}
