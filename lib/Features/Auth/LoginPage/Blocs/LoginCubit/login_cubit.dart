import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Auth/LoginPage/Services/LoginService.dart';
import 'package:hafazni/Features/Home/HomePage/View/HomePage.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(ChangePasswordVisiableState());
  final LoginService _service = LoginService();
  bool showPassword = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  void changePassword() {
    showPassword = !showPassword;
    emit(ChangePasswordVisiableState());
  }

  void login() async {
    if (formKey.currentState != null && !formKey.currentState!.validate()) {
      return;
    }
    var res = await Helper.showLoading(
      "جاري تسجيل الدخول",
      'يرجى الانتظار',
      () => _service.login(email.trim(), password.trim()),
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
    Get.offAll(() => const HomePage());
  }
}
