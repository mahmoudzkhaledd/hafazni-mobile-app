import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Home/HomePage/View/HomePage.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/AppConfigs.dart';
import 'package:hafazni/Models/ResponseResult.dart';
import 'package:hafazni/Shared/AppReposetory.dart';
import 'package:hafazni/services/AppUser.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';
import 'package:hafazni/services/GeneralServices/StorageService.dart';
import 'package:meta/meta.dart';
import '../../../Service/EmailVerificationService.dart';

part 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit(this.email) : super(EmailVerificationInitial());
  String codeStr = "";
  final String email;
  final EmailVerificationService _service = EmailVerificationService();
  void resendEmail() async {
    ResponseResult res = await Helper.showLoading<ResponseResult>(
      "جاري الارسال من جديد",
      "يرجى الانتظار قليلا",
      () => _service.resendVerificationEmail(email),
    );
    if (!res.success) {
      if (res.msg != null) {
        await Helper.showMessage(
          "خطا اثناء الارسال",
          res.msg!,
          icon: res.icon,
        );
      }
      if (res.callBack != null) {
        res.callBack!();
      }
      return;
    }
    await Helper.showMessage(
      "تم الارسال بنجاح",
      "يرجى مراعات ان عملية الارسال القادمة ستكون بعد 60 ثانية",
      icon: Icons.check_circle,
    );
  }

  void verifyEmail() async {
    int? code = int.tryParse(codeStr);
    if (code == null) {
      await Helper.showMessage(
        'خطأ في كتابة الكود',
        'من فضلك اعد كتابة الكود',
      );
      codeStr = "";
      return;
    }

    ResponseResult res = await Helper.showLoading<ResponseResult>(
      "جاري التحقق من الرقم",
      'من فضلك انتظر قليلا',
      () => _service.verifyEmail(
        code,
        Get.find<AppUser>().user!.id,
      ),
    );
    if (!res.success) {
      if (res.msg != null) {
        await Helper.showMessage(
          "خطأ اثناء التحقق من الايميل",
          res.msg!,
        );
      }
      if (res.callBack != null) {
        res.callBack!();
      }
      return;
    }
    NetworkService.refreshAccessToken(res.data['token']);
    await StorageServices.instance.saveUserToken(res.data['token']);
    AppRepository.appConfigs = AppConfigs.fromJson(res.data['appConfigs']);
    if (res.data['user']['wallet'] != null) {
      Get.find<AppUser>().user!.wallet = res.data['user']['wallet'];
    }
    Get.offAll(() => const HomePage());
  }
}
