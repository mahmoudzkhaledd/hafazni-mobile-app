import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Auth/StartingPage/View/StartingPage.dart';
import 'package:hafazni/Models/ResponseResult.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';

class AccountTypeService {
  final Dio dio = NetworkService.instance;
  Future<ResponseResult> getAccountTypes() async {
    try {
      var res = await dio.get('account-types');
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        success: true,
      );
    } on DioException catch (e) {
      var res = e.response;
      if (res == null) {
        return ResponseResult(
          data: null,
          icon: null,
          msg: null,
          success: false,
          internet: false,
        );
      }
      return ResponseResult(
        data: null,
        icon: Icons.close,
        msg: "لا يوجد لديك صلاحية لرؤية هذه البيانات",
        callBack: () => Get.offAll(() => const LandingPage()),
        success: true,
      );
    }
  }

  Future<ResponseResult> deleteAccountTyep(bool isUser) async {
    try {
      var res =
          await dio.delete('account-types/${isUser ? "user" : "memorizer"}');
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        success: res.statusCode == 200,
      );
    } on DioException catch (e) {
      var res = e.response;
      if (res == null) {
        return ResponseResult(
          data: null,
          icon: FontAwesomeIcons.globe,
          msg: null,
          success: false,
          internet: false,
        );
      }
      return ResponseResult(
        data: null,
        icon: Icons.close,
        msg: "لا يوجد لديك صلاحية لرؤية هذه البيانات",
        callBack: () => Get.offAll(() => const LandingPage()),
        success: true,
      );
    }
  }
}
