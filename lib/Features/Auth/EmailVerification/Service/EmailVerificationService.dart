import 'package:dio/dio.dart' as dioPage;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:hafazni/Models/ResponseResult.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';

import '../../../Home/HomePage/View/HomePage.dart';
import '../../StartingPage/View/StartingPage.dart';

class EmailVerificationService {
  final dioPage.Dio dio = NetworkService.instance;
  Future<ResponseResult> verifyEmail(int code, String id) async {
    try {
      dioPage.Response res = await dio.post(
        'verify-account',
        data: {
          "code": code,
        },
      );
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        success: res.statusCode == 200,
      );
    } on dioPage.DioException catch (ex) {
      ResponseResult response = ResponseResult(
        data: null,
        icon: null,
        msg: null,
        success: false,
      );

      var res = ex.response;
      if (res == null) {
        response.internet = false;
        response.msg = null;
        response.success = false;
        return response;
      }

      switch (res.statusCode) {
        case 401:
          response.internet = false;
          response.msg =
              "لا يوجد لديك صلاحية لتفعيل هذا الحساب, سوف يتم تحويلك لصفحة البداية";
          response.callBack = () => Get.offAll(() => const LandingPage());
        case 405:
          response.msg =
              "تم تفعيل الحساب بالفعل سوف يتم تحويلك الى الصفحة الرئيسية";
          response.callBack = () => Get.offAll(() => const HomePage());
        case 404:
          response.msg =
              "لا يوجد مستخدم بالبيانات المرسلة, سوف يتم تحويلك الى صفحة انشاء حساب جديد";
          response.callBack = () => Get.offAll(() => const LandingPage());
        case 406:
          response.msg = "الرجاء اعادة ارسال ايميل التفعيل";
        case 420:
          response.msg = "لقد استنفذت عدد المحاولات لديك وتم اغلاق حسابك";
          response.callBack = () {
            Get.offAll(() => const LandingPage());
          };
        case 409:
          response.msg =
              "الكود خطأ, لديك ${res.data['trails']} محاولة متبقية ويتم حذف الحساب";
      }
      return response;
    }
  }

  Future<ResponseResult> resendVerificationEmail(String email) async {
    try {
      var res = await dio.get("verify-account/resend?email=$email");
      return ResponseResult(
        data: null,
        icon: null,
        msg: null,
        success: res.statusCode == 200,
      );
    } on dioPage.DioException catch (ex) {
      var res = ex.response;
      if (res == null) {
        return ResponseResult(
          data: null,
          icon: FontAwesomeIcons.globe,
          msg: "من فضلك تحقق من الاتصال بالانترنت",
          success: false,
        );
      }
      var response =
          ResponseResult(data: null, icon: null, msg: null, success: false);
      switch (res.statusCode) {
        case 402:
          response.msg =
              "لا يوجد مستخدم بهذه البيانات, سوف يتم تحويلك الى صفحة البداية";
          response.callBack = () => Get.offAll(() => const LandingPage());
        case 401:
          response.msg =
              "لقد استنفذت عدد المحاولات لديك اليوم, برجاء العودة بعد 24 ساعة";
          response.callBack = () => Get.offAll(() => const LandingPage());
        case 405:
          response.msg =
              "يجب الانتظار على الاقل 60 ثانية ليتم الارسال من جديد باقي ${res.data['time']} ثانية على الارسال الجديد";
      }
      return response;
    }
  }
}
