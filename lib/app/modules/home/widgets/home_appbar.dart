import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/consts.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/open_drawer_widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeAppBar extends GetView<HomeController>
    implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  const HomeAppBar({Key? key, this.bottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const OpenDrawerWidget(),
      title: const Text(
        AppConstant.appName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kBottomNavigationBarHeight);
}
