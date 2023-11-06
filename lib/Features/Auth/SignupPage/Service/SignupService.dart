import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/Models/User.dart';
import 'package:hafazni/services/AppUser.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';

import '../../../../Models/ResponseResult.dart';

class SignupService {
  final Dio dio = NetworkService.instance;
  Future<ResponseResult> signup(User user) async {
    try {
      Map<String, dynamic> mp = user.toJsonSignup();
      mp['deviceId'] = Get.find<AppUser>().deviceToken;
      var res = await dio.post(
        'signup',
        data: mp,
      );

      return ResponseResult(
        success: res.statusCode == 200,
        icon: null,
        msg: null,
        data: res.data,
      );
    } on DioException catch (ex) {
      var res = ex.response;

      if (res == null) {
        return ResponseResult(
          success: false,
          icon: null,
          internet: false,
          msg: null,
          data: null,
        );
      }

      if (res.statusCode == 400) {
        return ResponseResult(
          success: false,
          icon: FontAwesomeIcons.faceSadCry,
          msg: null,
          data: res.data,
        );
      }
      if (res.statusCode == 409) {
        return ResponseResult(
          success: false,
          icon: FontAwesomeIcons.faceSadCry,
          msg: "هذا الايميل مستخدم من قبل, الرجاء تسجيل الدخول",
          data: null,
        );
      }
      return ResponseResult(
        success: false,
        icon: FontAwesomeIcons.faceSadCry,
        msg: null,
        data: res.data['msg'],
      );
    }
  }
}
