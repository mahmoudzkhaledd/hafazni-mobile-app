import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hafazni/Models/ResponseResult.dart';
import 'package:hafazni/Models/User.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileService {
  final dio = NetworkService.instance;
  Future<ResponseResult> loadUser(String id) async {
    try {
      var res = await dio.get('users/$id');

      if (res.data['user']['memorizerData'] != null &&
          res.data['currentPlansCount'] != null) {
        res.data['user']['memorizerData']['currentPlansCount'] =
            res.data['currentPlansCount'];
      }
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
      if (res.statusCode == 420) {
        return ResponseResult(
          data: res.data,
          icon: FontAwesomeIcons.circleExclamation,
          msg: "ليم يتم العثور على بروفايل المستخدم",
          success: false,
        );
      }
      return ResponseResult(
        data: null,
        icon: null,
        msg: null,
        success: false,
      );
    }
  }

  Future<ResponseResult> updateProfile(User newUser) async {
    var res = await NetworkService.handelRequest(
      future: dio.put(
        'users/profile/edit',
        data: newUser.toJsonSignup(),
      ),
    );
    if (res == null) {
      return ResponseResult(
        data: null,
        icon: null,
        msg: null,
        internet: true,
        success: false,
      );
    }
    if (res.statusCode == 200) {
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        success: true,
      );
    }
    return ResponseResult(
      data: res.data,
      icon: null,
      msg: null,
      success: false,
    );
  }

  Future<ResponseResult> uploadPhoto(
      XFile file, Function(int, int) onSend) async {
    FormData fd = FormData.fromMap({
      'filename': await MultipartFile.fromFile(
        file.path,
        filename: file.name,
      ),
    });
    var res = await NetworkService.handelRequest(
      future: dio.put(
        'users/profile/edit/upload-photo',
        data: fd,
        onSendProgress: onSend,
      ),
    );
    if (res == null) {
      return ResponseResult(
        data: null,
        icon: null,
        msg: null,
        internet: true,
        success: false,
      );
    }
    if (res.statusCode == 200) {
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        internet: true,
        success: true,
      );
    } else if (res.statusCode == 401) {
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: 'حجم الصورة اكبر من 5 MB',
        success: false,
      );
    }
    return ResponseResult(
      data: res.data,
      icon: null,
      msg: null,
      internet: true,
      success: false,
    );
  }

  Future<bool> deleteImage() async {
    var res = await NetworkService.handelRequest(
      future: dio.delete(
        'users/profile/edit/upload-photo',
      ),
    );

    if (res == null || res.statusCode != 200) {
      return false;
    }
    return res.data['res'];
  }
}
