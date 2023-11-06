import 'package:get/get.dart';

class RatingDialogeController extends GetxController {
  double rating = 0;
  RatingDialogeController(double r) {
    rating = r;
  }

  void changeRating(double value) {
    if (rating != value) {
      rating = value;
      update();
    }
  }

  void done() {
    Get.back<double>(result: rating);
  }
}
