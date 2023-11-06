import 'package:get/get.dart';
import 'package:hafazni/Features/Memorizer/Plans/AddPlanPage/View/Dialoges/ShowPreqsDialoge/View/AddPreqsDialoge.dart';

class ShowPreqsDialogeCtrl extends GetxController {
  final List<String> preqs;
  ShowPreqsDialogeCtrl(this.preqs);

  void removePreqs(String e) {
    preqs.remove(e);
    update();
  }

  void addPreqs() async {
    String? res = await Get.dialog(const AddPreqsDialoge());
    if (res != null && !preqs.contains(res)) {
      preqs.add(res);
      update();
    }
  }
}
