// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import, unnecessary_import, unnecessary_string_interpolations, must_be_immutable
// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lavoro/app/data/model/companyModel.dart';

import 'package:lavoro/app/data/model/job_model.dart';
import 'package:lavoro/app/data/model/user_model.dart';
import 'package:lavoro/app/modules/company_profile/compant_profile_view.dart';
import 'package:lavoro/app/modules/user_profile/view/user_profile_view.dart';
import 'package:url_launcher/url_launcher.dart';

class EmpCardView extends StatefulWidget {
 
  UserAccount users;

   UserAccount userss;
  
  EmpCardView({
    Key? key,
    required this.users,
 
    required this.userss
  
  }) : super(key: key);

  @override
  _EmpCardView createState() => _EmpCardView ();
}

class _EmpCardView  extends State<EmpCardView > {
 bool isDataAvailable = false;
  @override
  void initState() {
    super.initState();
    checkDataAvailability();
  }

  void checkDataAvailability() {
    // Check if company's selected languages match job's selected languages
    List<String> list1 = widget.users.selectedLanguage;
    List<String> list2 = widget.userss.selectedLanguage;
    
    bool languagesMatch = list1.any((language) => list2.contains(language));
    bool jobsMatch = widget.users.selectedjobs.contains(widget.userss.selectedjobs);
bool usermatch =widget.users.email.contains(widget.userss.email)==false;
    setState(() {
      // Set isDataAvailable to true if either condition is met
      isDataAvailable = (usermatch&&(languagesMatch||jobsMatch));
    });
  }
  Widget build(BuildContext context) {
    if (isDataAvailable) {
   
    return Card(
      borderOnForeground: true,
      elevation: 100,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
onTap: () async {
    final url = 'mailto:${widget.users.email}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("no go");
    }
  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(widget.users.imageUrl),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' ${widget.users.username}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' ${widget.users.email}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        
                      ),
                      Text(
                        ' ${widget.users.email}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        
                      ),
                         Divider(height:12,),
                           SizedBox(height: 4),
                      Text(
                        'Phone Number : ${widget.users.phoneNumber}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        
                      ),
                      SizedBox(height: 4),
                        Divider(height:12,),
                      Text(
                        ' ${widget.users.selectedjobs}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        
                        
                      ),
                      

                      SizedBox(height: 4),
                         Divider(height:12,),
                       Text(
                        ' City: ${widget.users.country}',
                        style: TextStyle(fontSize: 16,
                         fontWeight: FontWeight.bold,),
                        
                      ),
                       SizedBox(height: 4),
                       Divider(height:12,),
                      Text(
                        'Programing languges: ${widget.users.selectedLanguage}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.users.descrption}',
              style: TextStyle(fontSize: 16),
            ),
          ),
        
          SizedBox(height: 8),
          SizedBox(
            height: 12,
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
    return SizedBox();
}
}