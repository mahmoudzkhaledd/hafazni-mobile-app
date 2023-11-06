import 'package:get/get.dart';

class UploadingCtrl extends GetxController {
  double val = 0;
  void onChanged(int curr, int total) {
    val = curr / total;
    update();
  }
}
