// ... other imports

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/data/model/emp_model.dart';
import 'package:lavoro/app/data/model/user_model.dart';
import 'package:lavoro/app/modules/emp_home/widgets/card_view.dart';

import '../../../data/model/companyModel.dart';
import '../../../data/model/job_model.dart';
import '../../../global_widgets/adv.dart';
import '../../../global_widgets/text_theme.dart';
import '../../home/category/lang.dart';
import '../../home/widgets/home_card.dart';
import '../controllers/emp_home_controller.dart';
import '../emp_category/jobs_it.dart';

class EmpHomeBody extends GetView<EmpHomeController> {
  const EmpHomeBody({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 0,
            thickness: 10,
            color: Colors.black,
          ),
          SizedBox(height: 20),
          Text(
            "    Information Technology Jobs",
            style: AppStyles.headLine3.copyWith(
              color: Get.theme.colorScheme.onBackground,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10),
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.black,
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: EmpCategoriesRow(),
          ),

          SizedBox(height: 15),
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.black,
          ),
          SizedBox(height: 20),
          if (UserAccount.info?.isCompany == false)
            Text(
              "    Users with same interests",
              style: AppStyles.headLine3.copyWith(
                color: Get.theme.colorScheme.onBackground,
              ),
              textAlign: TextAlign.start,
            ),
          if (UserAccount.info?.isCompany == true)
            Text(
              "    Recommended Users for you.",
              style: AppStyles.headLine3.copyWith(
                color: Get.theme.colorScheme.onBackground,
              ),
              textAlign: TextAlign.start,
            ),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.black,
          ),

          // Use ListView.builder to display multiple CardViews
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.allusers.length,
              itemBuilder: (context, index) {
                UserModel user = controller.allusers[index];
                UserAccount? currentUser = UserAccount.info;

                if (currentUser != null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: EmpCardView(users: user, currentUser: currentUser),
                  );
                } else {
                  // Handle the case when currentUser is null
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
