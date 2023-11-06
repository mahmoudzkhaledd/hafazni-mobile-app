import 'package:get/get.dart';

class ReadingsController extends GetxController {
  List<int> readings = [];
  Map<int, bool> chosen = {};
  ReadingsController(List<int> r) {
    readings = r;
    if (readings.isNotEmpty) {
      for (int x in readings) {
        chosen[x] = true;
      }
      update();
    }
  }
  void chooseReading(int reading) {
    if (chosen[reading] != true) {
      chosen[reading] = true;
    } else {
      chosen.remove(reading);
    }
    update();
  }

  void done() {
    final List<int> r = [];
    for (int i in chosen.keys) {
      r.add(i);
    }
    Get.back<List<int>>(result: r);
  }

  void restore() {
    if (chosen.isNotEmpty) {
      chosen.clear();
      update();
    }
  }
}
