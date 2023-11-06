import 'package:dio/dio.dart' as dioPage;
import 'package:get/get.dart';
import 'package:hafazni/Models/User.dart';
import 'package:hafazni/services/AppUser.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';

import '../../../../Models/AppConfigs.dart';
import '../../../../Shared/AppReposetory.dart';

class SplashScreenService {
  final dioPage.Dio dio = NetworkService.instance;
  Future<bool> checkAuth() async {
    try {
      dioPage.Response res = await dio.post(
        'login/token',
        data: {
          'deviceToken': Get.find<AppUser>().deviceToken,
        },
      );
      if (res.statusCode == 200) {
        Get.find<AppUser>().user = User.fromJson(res.data['user']);
        AppRepository.appConfigs = AppConfigs.fromJson(res.data['appConfigs']);

        return true;
      }

      return false;
    } on dioPage.DioException catch (_) {
      return false;
    }
  }
}
