// ... other imports

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/data/model/companyModel.dart';
import 'package:lavoro/app/data/model/job_model.dart';
import 'package:lavoro/app/data/model/user_model.dart';
import 'package:lavoro/app/modules/home/controllers/home_controller.dart';
import 'package:lavoro/app/modules/home/controllers/job_controller.dart';
import 'package:lavoro/app/modules/home/widgets/home_card.dart';
import '../../../global_widgets/adv.dart';
import '../../../global_widgets/text_theme.dart';
import '../category/lang.dart';

class HomeBody extends GetView<HomeController> {
  const HomeBody({Key? key});

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

          CarouselSection(),
          SizedBox(height: 20),
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.black,
          ),
          SizedBox(height: 10),
          Text(
            "     Information Technology Jobs",
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
            child: CategoriesRow(),
          ),

          SizedBox(height: 15),
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.black,
          ),
          SizedBox(height: 20),
          if(UserAccount.info?.isCompany==false)
          Text(
            "    Jobs suitable for your interests",
            style: AppStyles.headLine3.copyWith(
              color: Get.theme.colorScheme.onBackground,
            ),
            textAlign: TextAlign.start,
          ),
          if(UserAccount.info?.isCompany==true)
          Text(
            "    Similar companies.",
            style: AppStyles.headLine3.copyWith(
              color: Get.theme.colorScheme.onBackground,
            ),
            textAlign: TextAlign.start,
          ),
         
          // Use ListView.builder to display multiple CardViews
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.allJobs.length,
              itemBuilder: (context, index) {
                CreateJobAcount job = controller.allJobs[index];
UserAccount user=UserAccount.info!;
                return FutureBuilder<CompanyModel>(
                  future: controller.getcompany(job.companyId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      CompanyModel? company = snapshot.data;

                      if (company != null) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: MyCardView(job: job, company: company,users:user),
                        );
                      } else {
                        // Handle the case where user is null
                        return SizedBox.shrink();
                      }
                    } else {
                      // While the future is still resolving
                      return CircularProgressIndicator();
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
