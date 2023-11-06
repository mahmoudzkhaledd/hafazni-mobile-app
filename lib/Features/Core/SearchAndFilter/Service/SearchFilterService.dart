import 'package:dio/dio.dart';
import 'package:hafazni/Features/Core/SearchAndFilter/Models/FilterationMode.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';

import '../../../../Models/ResponseResult.dart';

class SearchFilterService {
  final dio = NetworkService.instance;
  Future<ResponseResult> search(FilterationModel model) async {
    try {
      var res = await dio.get(model.requestUrl);

      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        success: true,
      );
    } on DioException catch (_) {
      return ResponseResult(
        data: null,
        icon: null,
        msg: null,
        success: false,
      );
    }
  }
}
