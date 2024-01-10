import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../global_widgets/custom_button.dart';


class CustomCompanyProfileListTile extends StatelessWidget {
  final String label;
  final IconData icons;
  final Function()? onTap;
  final bool showCopyButton;
  final List<String>? text; // Making the list optional by using List<String>?

  const CustomCompanyProfileListTile({
    Key? key,
    required this.label,
    required this.icons,
    this.text, // Making the list optional
    this.onTap,
    this.showCopyButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0), // You can adjust the radius here
        side: const BorderSide(
          color: Colors.purple, // Adjust the outline color here
          width: 1.0,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Same radius as the Card
        ),
        leading: Icon(icons),
        title: Text(label),
        subtitle: text != null && text!.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: text!.map((item) {
                  return Text(
                    item,
                    style: const TextStyle(fontSize: 14), // Adjust font size as needed
                  );
                }).toList(),
              )
            : null,
        onTap: onTap,
        trailing: showCopyButton
            ? CustomButton(
                width: 35,
                height: 35,
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: label));
                  Fluttertoast.showToast(
                    msg: "copiedToClipboard".tr,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Get.theme.colorScheme.background,
                    textColor: Get.theme.colorScheme.onBackground,
                  );
                },
                child: const Icon(Icons.copy),
              )
            : null,
      ),
    );
  }
}
