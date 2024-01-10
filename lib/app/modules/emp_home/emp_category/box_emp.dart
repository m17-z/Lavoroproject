// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lavoro/app/modules/emp_home/emp_category/cat_view.dart';


class langBox extends StatelessWidget {
  final String imagePath;
  final String name;
  final Function() onPressed;

  const langBox({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to CategoryPage and send the name
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  EmpCatView(
              categoryName: name,
            ),
          ),
        );
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          // Set background color here
          border: Border.all(
            color: Colors.black, // Set border color here
            width: 2.0,
           // Set border width here
          ),
         color: Colors.white,
          borderRadius: BorderRadius.circular(10.0), // Set border radius here
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5),
            Text(name, textAlign: TextAlign.center,style: TextStyle(color: Colors.black),
            ),
            if (name == "Data Scientist")
              const SizedBox(height: 20),
              if (name == "AI Developer")
              const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
