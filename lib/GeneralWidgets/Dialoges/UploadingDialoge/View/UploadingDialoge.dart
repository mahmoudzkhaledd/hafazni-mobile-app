import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../Ctrl/UploadingDialogeCtrl.dart';

class UploadingDialoge extends GetView<UploadingCtrl> {
  const UploadingDialoge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/uploading.json',
          ),
          GetBuilder<UploadingCtrl>(
            builder: (ctrl) => LinearProgressIndicator(
              value: ctrl.val,
            ),
          ),
        ],
      ),
    );
  }
}
