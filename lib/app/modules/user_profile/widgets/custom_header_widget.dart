// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavoro/app/data/model/companyModel.dart';

import '../../../core/utils/helpers/custom_bottom_sheet.dart';
import '../../../data/model/user_model.dart';
import '../../../data/provider/firebase_image.dart';
import '../../../global_widgets/image_viewer_list.dart';

class CustomHeaderWidget extends StatefulWidget {
  CompanyModel? useraccount;
  bool isnotuser;
  CustomHeaderWidget({
    Key? key,
    this.useraccount,
    required this.isnotuser,
  }) : super(key: key);

  @override
  State<CustomHeaderWidget> createState() => _CustomHeaderWidgetState();
}

class _CustomHeaderWidgetState extends State<CustomHeaderWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = UserAccount.info;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          GestureDetector(
            onTap: () {
              ImageViewerList.show(imageUrls: [
                widget.isnotuser ? widget.useraccount!.imageUrl : user!.imageUrl
              ]);
            },
            child: Stack(
              children: [
                Hero(
                  tag: widget.isnotuser
                      ? widget.useraccount!.imageUrl
                      : user!.imageUrl,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          width: 140,
                          height: 140,
                          image: CachedNetworkImageProvider(widget.isnotuser
                              ? widget.useraccount!.imageUrl
                              : user!.imageUrl),
                        ),
                      ),
                    ),
                  ),
                ),
                if (isLoading)
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CircularProgressIndicator(),
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: widget.isnotuser
                      ? const SizedBox()
                      : MaterialButton(
                          height: 35,
                          minWidth: 35,
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Get.theme.colorScheme.background,
                              width: 4,
                            ),
                          ),
                          color: Get.theme.colorScheme.background,
                          child: Icon(
                            Icons.edit,
                            size: 16.0,
                            color: Get.theme.colorScheme.onBackground,
                          ),
                          onPressed: () async {
                            final res = await CustomBottomSheet.imagePiker();
                            if (res != null) {
                              setState(() => isLoading = true);
                              final imagePath = res.path;
                              final uid = UserAccount.info!.uid!;
                              final newImageUrl =
                                  await FirebaseImage.uploadUserImage(
                                imagePath: imagePath,
                                uid: uid,
                              );
                              if (newImageUrl != null) {
                                UserAccount.info!.imageUrl = newImageUrl;
                              }
                              setState(() => isLoading = false);
                            }
                          },
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              widget.isnotuser ? widget.useraccount!.username : user!.username,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            
          ),
        ]),
      ),
    );
  }
}
