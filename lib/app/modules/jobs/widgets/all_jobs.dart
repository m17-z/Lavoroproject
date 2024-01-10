import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/data/model/job_model.dart';
import 'package:lavoro/app/modules/jobs/widgets/all_jobs_body.dart';

import '../../../data/model/companyModel.dart';

import '../../home/controllers/home_controller.dart';
import '../../home/widgets/home_card.dart';

class AllJobsBody extends GetView<HomeController> {
  const AllJobsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          height: 0,
          thickness: 1,
          color: Colors.black,
        ),
        const SizedBox(height: 20),
       
      
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.allJobs.length,
            itemBuilder: (context, index) {
              CreateJobAcount job = controller.allJobs[index];

              return FutureBuilder<CompanyModel>(
                future: controller.getcompany(job.companyId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    CompanyModel? company = snapshot.data;

                    if (company != null) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child:JobsPages(job: job, company: company),
                      );
                    } else {
                      // Handle the case where company is null
                      return const SizedBox.shrink();
                    }
                  } else {
                    // While the future is still resolving
                    return const CircularProgressIndicator();
                  }
                },
              );
            },
          ),
        ),
      ],
    ))
    ;
  }
}