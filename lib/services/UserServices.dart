import 'package:hafazni/services/GeneralServices/NetworkService.dart';
import 'package:dio/dio.dart';

import 'AccountServices.dart';

class UserServices {
  final Dio dio = NetworkService.instance;
  Future<Response?> updateUserData(Map<String, dynamic> json) async {
    Response? res = await NetworkService.handelRequest(
      future: dio.put(
          'users/${AccountServices.instance.user!.id}/update-health',
          data: json),
    );
    return res;
  }
}
