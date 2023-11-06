import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart' as getx;
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Shared/Secrets.dart';
import 'package:dio/dio.dart';
import 'package:hafazni/services/AppUser.dart';

class NetworkService {
  static String devBaseUrl = "http://192.168.1.8:3000/";
  static String runBaseUrl = "https://hafazni.onrender.com/";
  static late Dio instance;
  static String accessToken = "";

  static Future<Response?> handelRequest({
    required Future<Response> future,
  }) async {
    try {
      Response res = await future;
      return res;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  static void initDio() {
    BaseOptions options = BaseOptions(
      baseUrl: Secrets.appMode == ApplicationMode.dev ? devBaseUrl : runBaseUrl,
      receiveTimeout: Secrets.appMode == ApplicationMode.dev
          ? const Duration(seconds: 10)
          : const Duration(seconds: 50),
      connectTimeout: Secrets.appMode == ApplicationMode.dev
          ? const Duration(seconds: 10)
          : const Duration(seconds: 50),
      contentType: 'application/json',
    );
    instance = Dio(options);
    refreshAccessToken(accessToken);
  }

  static void refreshAccessToken(String token) {
    accessToken = token;
    var inter = InterceptorsWrapper(
      onRequest: (options, handeler) async {
        options.headers['token'] = 'Bearer $accessToken';
        options.headers['appKey'] = Secrets.secretKey;
        return handeler.next(options);
      },
      onError: (e, handler) async {
        var res = e.response;
        if (res == null || e.type == DioExceptionType.connectionTimeout) {
          await Helper.showMessage(
            "خطأ في الاتصال",
            "يرجى التحقق من الاتصال بالانترنت",
            icon: FontAwesomeIcons.globe,
          );
          return handler.next(e);
        }
        if (res.statusCode == 455) {
          await Helper.showMessage(
            "خطأ في الصلاحيات",
            "لا يوجد لديك صلاحية للقيام بهذة العميلة",
            icon: FontAwesomeIcons.globe,
          );
          await getx.Get.find<AppUser>().signOut();
          return;
        }
        return handler.next(e);
      },
    );
    if (instance.interceptors.length != 2) {
      instance.interceptors.add(inter);
      return;
    }
    instance.interceptors.last = inter;
  }
}
