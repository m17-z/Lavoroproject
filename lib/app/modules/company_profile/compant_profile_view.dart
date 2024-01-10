// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

import 'package:lavoro/app/data/model/companyModel.dart';

import 'company_profile_body.dart';

class CompanyProfileView extends StatelessWidget {
  CompanyModel? company;
  bool isnotuser;
  CompanyProfileView({
    Key? key,
    this.company,
    required this.isnotuser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        title: const Text(
          'Company profile',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
              fontSize: 26),
              
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: CompanyProfile(company: company, isnotuser: isnotuser),
    
      );
      
  }
}
