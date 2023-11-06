import 'package:dio/dio.dart';
import 'package:hafazni/Models/ResponseResult.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:http_parser/http_parser.dart';

class MemorizerAccountTypeService {
  final Dio dio = NetworkService.instance;
  Future<ResponseResult> saveData(
    String desc,
    List<int> readings,
    String? url,
    bool save,
  ) async {
    try {
      var res = await dio.put(
        '/account-types/memorizer',
        data: {
          "save": save,
          "description": desc,
          "readings": readings,
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
        data: null,
        icon: null,
        msg: res.data.toString(),
        success: true,
      );
    }
  }

  Future<ResponseResult> uploadImage(
    XFile file,
    Function(int, int) onSend,
  ) async {
    FormData data = FormData.fromMap({
      'filename': await MultipartFile.fromFile(
        file.path,
        filename: file.name,
      ),
    });
    try {
      var res = await dio.put(
        '/account-types/memorizer?uploadOnly=true',
        data: data,
        onSendProgress: onSend,
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
        data: null,
        icon: null,
        msg: res.data.toString(),
        success: true,
      );
    }
  }

  Future<bool> deleteImage(String url) async {
    try {
      var res = await dio.delete('/account-types/certificate', data: {
        "url": url,
      });

      return res.data['result'];
    } on DioException catch (_) {
      
      return false;
    }
  }
}
