import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Auth/StartingPage/View/StartingPage.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/User.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';
import 'package:hafazni/services/GeneralServices/StorageService.dart';

class AppUser extends GetxController {
  User? user;
  AppUser();
  String deviceToken = "";
  Future<void> signOut() async {
    final dio = NetworkService.instance;
    try {
      var res = await dio.post('signout');

      if (res.statusCode == 200) {
        user = null;

        await StorageServices.instance.removeUserToken();
        NetworkService.refreshAccessToken('');
        Get.offAll(() => const LandingPage());
      }
    } on DioException catch (_) {

      await Helper.showMessage(
        'خطأ في تسجيل الخروج',
        "الرجاء اعادة المحاولة من جديد",
      );
    }
  }
}
