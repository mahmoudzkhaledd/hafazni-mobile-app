import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Service/MemorizerAccountService.dart';

class UploadImageCtrl extends GetxController {
  double progress = 0;

  UploadImageCtrl(XFile file) {
    uploadImage(file);
  }
  uploadImage(XFile file) async {
    var res = await MemorizerAccountTypeService().uploadImage(
      file,
      (current, total) {
        progress = current / total;
        update();
      },
    );
    Get.back<String>(result: res.data['url']);
  }
}
