import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'categorybox.dart';

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CategoryBox(
          imagePath: 'assets/images/jobs/web.png',
          name: 'Web Developer',
          onPressed: () {
            handleCategorySelection();
          },
        ),
        CategoryBox(
          imagePath: 'assets/images/jobs/mobile.png',
          name: 'Mobile App Developer',
          onPressed: () {
            handleCategorySelection();
          },
        ),
        CategoryBox(
          imagePath: 'assets/images/jobs/soft.png',
          name: 'Software Engineer',
          onPressed: () {
            handleCategorySelection();
          },
        ),
        CategoryBox(
          imagePath: 'assets/images/jobs/data.png',
          name: 'Data Scientist',
          onPressed: () {
            handleCategorySelection();
          },
        ),
        CategoryBox(
          imagePath: 'assets/images/jobs/net.png',
          name: 'Network Engineer',
          onPressed: () {
            handleCategorySelection();
          },
        ),
        CategoryBox(
          imagePath: 'assets/images/jobs/cyper.png',
          name: 'Cybersecurity Analyst',
          onPressed: () {
            handleCategorySelection();
          },
        ),
        CategoryBox(
          imagePath: 'assets/images/jobs/system.png',
          name: 'System Administrator',
          onPressed: () {
            handleCategorySelection();
          },
        ),
        CategoryBox(
          imagePath: 'assets/images/jobs/base.png',
          name: 'Database Administrator',
          onPressed: () {
            handleCategorySelection();
          },
        ),
        CategoryBox(
          imagePath: 'assets/images/jobs/ai.png',
          name: 'AI Developer',
          
          onPressed: () {
            handleCategorySelection();
          },
        ),
        CategoryBox(
          imagePath: 'assets/images/jobs/dev.png',
          name: 'DevOps Engineer',
          onPressed: () {
            handleCategorySelection();
          },
        ),
        CategoryBox(
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
