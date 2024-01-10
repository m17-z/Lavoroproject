import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'box_emp.dart';


class EmpCategoriesRow extends StatelessWidget {
  const EmpCategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        langBox(
          imagePath: 'assets/images/jobs/web.jpg',
          name: 'Web Developer',
          onPressed: () {
            handleCategorySelection();
          },
        ),
        langBox(
          imagePath: 'assets/images/jobs/mobile.png',
          name: 'Mobile App Developer',
          onPressed: () {
            handleCategorySelection();
          },
        ),
       langBox(
          imagePath: 'assets/images/jobs/soft.jpg',
          name: 'Software Engineer',
          onPressed: () {
            handleCategorySelection();
          },
        ),
       langBox(
          imagePath: 'assets/images/jobs/data.jpg',
          name: 'Data Scientist',
          onPressed: () {
            handleCategorySelection();
          },
        ),
       langBox(
          imagePath: 'assets/images/jobs/net.png',
          name: 'Network Engineer',
          onPressed: () {
            handleCategorySelection();
          },
        ),
       langBox(
          imagePath: 'assets/images/jobs/cyper.jpg',
          name: 'Cybersecurity Analyst',
          onPressed: () {
            handleCategorySelection();
          },
        ),
        langBox(
          imagePath: 'assets/images/jobs/system.jpg',
          name: 'System Administrator',
          onPressed: () {
            handleCategorySelection();
          },
        ),
        langBox(
          imagePath: 'assets/images/jobs/base.png',
          name: 'Database Administrator',
          onPressed: () {
            handleCategorySelection();
          },
        ),
        langBox(
          imagePath: 'assets/images/jobs/ai.jpg',
          name: 'AI Developer',
          
          onPressed: () {
            handleCategorySelection();
          },
        ),
        langBox(
          imagePath: 'assets/images/jobs/dev.jpg',
          name: 'DevOps Engineer',
          onPressed: () {
            handleCategorySelection();
          },
        ),
       langBox(
          imagePath: 'assets/images/jobs/game.png',
          name: 'Game Developer',
          onPressed: () {
            handleCategorySelection();
          },
        ),
      ],
    );
  }

// ignore: non_constant_identifier_names

  void handleCategorySelection() {
    // Implement your logic to handle the selected category
    if (kDebugMode) {
      print('Selected Category: ,');
    }
  }
}
