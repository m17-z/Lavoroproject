import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/job_controller.dart';
import 'Company_info.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreateJobController createJobController =
        Get.find<CreateJobController>();

    List<String>? skills = createJobController.languages[categoryName];

    return Scaffold(
      body: skills != null
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 30.0,
              ),
              itemCount: skills.length,
              itemBuilder: (context, index) {
                return buildSkillCard(context, skills[index]);
              },
            )
          : Center(
              child: Text('Skills not found for $categoryName'),
            ),
    );
  }

  Widget buildSkillCard(BuildContext context, String skill) {
    String imagePath = 'assets/images/languges/$skill.png';
    double width = 100;
    double height = 100;
    if (imagePath == 'assets/images/languges/Cisco-IOS.png') {
      width = 200;
      height = 100;
    }
    if (imagePath == 'assets/images/languges/Unity.png') {
      width = 150;
      height = 55;
    }
    if (imagePath == 'assets/images/languges/Unreal Engine.png') {
      width = 136;
      height = 110;
    }
    if (imagePath == 'assets/images/languges/MySQL.png') {
      width = 200;
      height = 110;
    }
    if (imagePath == 'assets/images/languges/PyTorch.png') {
      width = 200;
      height = 110;
    }
    if (imagePath == 'assets/images/languges/MongoDB.png') {
      width = 200;
      height = 110;
    }
    if (imagePath == 'assets/images/languges/Oracle.png') {
      width = 200;
      height = 110;
    }
    if (imagePath == 'assets/images/languges/Linux-Shell-Scripting.png') {
      width = 300;
      height = 100;
    }
     return GestureDetector(
    onTap: () {
      // Navigate to DetailPage and pass category name and skill text
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompanyInfo(
            categoryName: categoryName,
            skill: skill,
          ),
        ),
      );
    },
    child: Card(
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Text('Image not found');
              },
            ),
            const SizedBox(height: 8),
            Text(
              skill,
              style: const TextStyle(fontSize: 16,color: Colors.black) ,
              
            ),
          ],
        ),
      ),
    ));
  }
}
