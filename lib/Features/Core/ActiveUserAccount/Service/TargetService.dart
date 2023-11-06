import 'package:dio/dio.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';

import '../../../../Models/ResponseResult.dart';

class TargetService {
  final Dio dio = NetworkService.instance;
  Future<ResponseResult> updateTarget(int first, int sec) async {
    try {
      var res = await dio.put(
        'account-types/user',
        data: {
          "from": first,
          "to": sec,
        },
      );

      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        success: true,
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
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: res.data.toString(),
        success: false,
      );
    }
  }
}
