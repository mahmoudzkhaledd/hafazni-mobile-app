import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Auth/SignupPage/Service/SignupService.dart';
import 'package:hafazni/GeneralWidgets/Dialoges/CountriesDialoge/Controller/ContriesController.dart';
import 'package:hafazni/GeneralWidgets/Dialoges/CountriesDialoge/view/CountriesDialoge.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/ResponseResult.dart';
import 'package:hafazni/Models/User.dart';
import 'package:hafazni/services/AppUser.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';
import 'package:meta/meta.dart';

import '../../../../../Models/Country.dart';
import '../../../EmailVerification/EmailVerificationPage/View/EmailVerificationPage.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final User user = User();
  bool acceptConditions = false;
  bool showPassword = false;
  final SignupService _service = SignupService();

  void signup() async {
    if (formKey.currentState != null &&
        !formKey.currentState!.validate() &&
        user.country.code.isNotEmpty) {
      return;
    } else if (user.country.code.isEmpty) {
      await Helper.showMessage(
        "الدولة",
        "يجب وضع الدولة الخاصة بك",
        icon: FontAwesomeIcons.globe,
      );
      return;
    }
    if (!acceptConditions) {
      await Helper.showMessage(
        "الشروط و الاحكام",
        "يجب الموافقة على الشروط والاحكام الخاصة بالتطبيق",
        icon: FontAwesomeIcons.fileLines,
      );
      return;
    }
    ResponseResult res = await Helper.showLoading<ResponseResult>(
      "جاري انشاء حساب جديد",
      "من فضلك انتظر قليلا",
      () => _service.signup(user),
    );
    if (!res.success) {
      if (res.msg != null) {
        await Helper.showMessage(
          "خطأ اثناء إنشاء حساب",
          res.msg!,
          icon: res.icon,
        );
      }
      if (res.callBack != null) {
        res.callBack!();
      }
      return;
    }
    NetworkService.refreshAccessToken(res.data['token']);
    Get.find<AppUser>().user = User.fromJson(res.data['user']);
    Get.to(() => EmailVerificationPage(
          email: Get.find<AppUser>().user!.email,
        ));
  }

  void changeUserBirthDate() async {
    DateTime? date = await showDatePicker(
      context: Get.context!,
      initialDate: user.birthdate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      user.birthdate = date;
      emit(ChangeBirthdateState());
    }
  }

  void changePasswordVisability() {
    showPassword = !showPassword;
    emit(ChangePasswordVisabilityState());
  }

  void changeUserGender(bool? val) {
    if (val != null && val != user.gender) {
      user.gender = val;
      emit(ChangeGenderState());
    }
  }

  void changeConditions(bool val) {
    acceptConditions = !acceptConditions;
    emit(ChangeConditionsState());
  }

  void changeCountry() async {
    Get.put(CountriesController([], chooseOne: true));
    Country? res = await Get.dialog(const CountryDialoge());
    Get.delete<CountriesController>();
    if (res != null) {
      user.country = res;
      emit(ChangeCountryState());
    }
  }
}
