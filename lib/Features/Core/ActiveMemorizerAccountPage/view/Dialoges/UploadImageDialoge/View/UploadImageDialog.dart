import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:image_picker/image_picker.dart';

import '../Ctrl/UploadImageCtrl.dart';

class UploadImageDialoge extends GetView<UploadImageCtrl> {
  UploadImageDialoge({
    super.key,
    required XFile file,
  }) {
    Get.put(UploadImageCtrl(file));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: AlertDialog(
        content: GetBuilder<UploadImageCtrl>(
          builder: (ctrl) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                "جاري رفع الصورة",
                style: TextStyle(
                  fontFamily: FontFamily.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
                width: 1000,
              ),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: ctrl.progress,
                    ),
                  ),
                  const SizedBox(width: 10),
                  AppText(
                    "${(ctrl.progress * 100).toStringAsFixed(2)}%",
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
