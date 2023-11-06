import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart' as getx;
import 'package:hafazni/Models/ResponseResult.dart';
import 'package:hafazni/Models/User.dart';
import 'package:hafazni/services/AppUser.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';
import 'package:hafazni/services/GeneralServices/StorageService.dart';

import '../../../../Models/AppConfigs.dart';
import '../../../../Shared/AppReposetory.dart';
import '../../EmailVerification/EmailVerificationPage/View/EmailVerificationPage.dart';

class LoginService {
  final Dio dio = NetworkService.instance;
  Future<ResponseResult> login(String email, String password) async {
    try {
      var res = await dio.post(
        '/login',
        data: {
          "email": email,
          "password": password,
          "deviceToken": getx.Get.find<AppUser>().deviceToken,
        },
      );
      getx.Get.find<AppUser>().user = User.fromJson(res.data['user']);
      if (getx.Get.find<AppUser>().user!.verifiedEmail) {
        await StorageServices.instance.saveUserToken(res.data['token']);
        NetworkService.refreshAccessToken(res.data['token']);
        AppRepository.appConfigs = AppConfigs.fromJson(res.data['appConfigs']);
      }

      return ResponseResult(
        data: null,
        icon: null,
        msg: null,
        success: res.statusCode == 200,
      );
    } on DioException catch (ex) {
      var res = ex.response;
      if (res == null) {
        return ResponseResult(
          data: null,
          icon: null,
          msg: null,
          success: false,
        );
      }

      if (res.statusCode == 401) {
        return ResponseResult(
          data: null,
          icon: FontAwesomeIcons.faceSadCry,
          msg: "يرجى التحقق من الايميل او الباسورد",
          success: false,
        );
      }

      NetworkService.refreshAccessToken(res.data['token']);
      getx.Get.find<AppUser>().user = User.fromJson(res.data['user']);
      return ResponseResult(
        data: null,
        icon: null,
        msg: "يرجى تفعيل الحساب اولا, سيتم تحويلك الى صفحة التفعيل",
        success: false,
        callBack: () => getx.Get.to(() => EmailVerificationPage(
              email: getx.Get.find<AppUser>().user!.email,
            )),
      );
    }
  }
}
