import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Core/ActiveMemorizerAccountPage/view/Dialoges/UploadImageDialoge/View/UploadImageDialog.dart';
import 'package:hafazni/Features/Core/ActiveMemorizerAccountPage/view/Widgets/ImageDialoge.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/AccountType.dart';
import 'package:hafazni/Models/User.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../../services/AppUser.dart';
import '../../Service/MemorizerAccountService.dart';
import '../../view/Dialoges/UploadImageDialoge/Ctrl/UploadImageCtrl.dart';

part 'memorizer_account_state.dart';

class MemorizerAccountCubit extends Cubit<MemorizerAccountState> {
  MemorizerAccountCubit() : super(MemorizerAccountInitial()) {
    int c = 0;
    for (int i = 1; i <= 10; i++) {
      bool match = user.memorizerData != null &&
          c < user.memorizerData!.readings.length &&
          user.memorizerData!.readings[c] == i;
      checkedReadings[i] = match;
      if (match) c++;
    }
    imageUrl = user.memorizerData == null
        ? null
        : user.memorizerData!.certificant.isEmpty
            ? null
            : user.memorizerData!.certificant;
  }
  XFile? file;
  final user = Get.find<AppUser>().user!;
  final FocusNode focusNode = FocusNode();
  final MemorizerAccountTypeService _service = MemorizerAccountTypeService();
  String description = "";
  Map<int, bool> checkedReadings = {};
  String? imageUrl;
  @override
  Future<void> close() {
    focusNode.dispose();
    return super.close();
  }

  void viewImage() async {
    if (imageUrl == null) {
      // ignore: invalid_use_of_visible_for_testing_member
      file = await ImagePicker.platform.getImageFromSource(
        source: ImageSource.gallery,
      );
      if (file != null) {
        emit(MemorizerAccountInitial());
      }
    } else {
      showDialog(
        context: Get.context!,
        builder: (e) => ImageDialog(
          path: imageUrl!,
        ),
      );
    }
  }

  void onRemovePic() async {
    bool res =
        await Helper.showYesNoMessage('حذف الشهادة', "هل تريد حذف الشهادة؟");
    if (res) {
      var x = await Helper.showLoading(
        'جاري الحذف',
        "الرجاء الانتظار",
        () => _service.deleteImage(imageUrl!),
      );
      if (x) {
        file = null;
        imageUrl = null;
        user.memorizerData!.certificant = "";
      }
    }

    emit(MemorizerAccountInitial());
  }

  onCheckReading(int idx, bool chk) {
    checkedReadings[idx] = chk;
    emit(MemorizerAccountInitial());
  }

  Future<bool> saveData(bool save) async {
    bool result = await Helper.showYesNoMessage(
      "هل انت متاكد؟",
      save
          ? "سوف يتم حفظ البيانات على ملفك الشخصي لحين الاكمال هل انت متأكد؟"
          : "سوف يتم ارسال البيانات للمراجعة هل انت متاكد؟",
    );
    if (result) {
      List<int> readings = [];
      checkedReadings.forEach((key, value) {
        if (value) {
          readings.add(key);
        }
      });
      var res = await Helper.showLoading(
        'جاري الارسال',
        "يرجى الانتظار",
        () => _service.saveData(
          description,
          readings,
          imageUrl,
          save,
        ),
      );
      if (!res.success) {
        if (res.msg != null) await Helper.showMessage("خطأ", res.msg!);
        if (res.callBack != null) res.callBack!();
        return false;
      }
      user.memorizerData = MemorizerData();
      user.memorizerData!.describtion = description;
      user.memorizerData!.readings = readings;
      user.memorizerData!.state =
          save ? AccountTypeState.saved : AccountTypeState.pending;
      await Helper.showMessage(
        "عملية ناجحة",
        "تم تحديث البيانات بنجاج",
        icon: Icons.check_circle,
      );
      return true;
    }
    return false;
  }

  void submitText() => focusNode.unfocus();
  void uploadImageService() async {
    await _service.uploadImage(file!, (p0, p1) => null);
  }

  void uploadImage() async {
    if (user.memorizerData == null) {
      bool res = await saveData(false);
      if (!res) {
        return;
      }
    }
    String? res = await Get.dialog<String>(UploadImageDialoge(
      file: file!,
    ));
    Get.delete<UploadImageCtrl>();
    if (res != null) {
      imageUrl = res;
      user.memorizerData!.certificant = res;
      file = null;
      emit(MemorizerAccountInitial());
    }
  }
}
