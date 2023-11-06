import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hafazni/Models/PromoCode.dart';
import 'package:hafazni/Models/ResponseResult.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';

class CouponsService {
  final dio = NetworkService.instance;
  Future<ResponseResult> addCoupon(PromoCode promoCode) async {
    try {
      var res = await dio.post(
        'coupons',
        data: promoCode.toJson(),
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
          internet: true,
          success: false,
        );
      }

      if (res.statusCode == 402) {
        return ResponseResult(
          data: res.data,
          icon: FontAwesomeIcons.copy,
          msg: (res.data['sameCode'] && res.data['sameName'])
              ? "يوجد كوبون اخر بنفس الكود والاسم"
              : res.data['sameCode']
                  ? "يوجد كوبون اخر بنفس الكود"
                  : "يوجد كوبون اخر بنفس الاسم",
          success: false,
        );
      }
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        success: false,
      );
    }
  }

  Future<ResponseResult> getUserCoupons({double? price}) async {
    try {
      var res = await dio.get(
        'coupons${price != null ? "?price=$price" : ""}',
      );
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        success: true,
      );
    } catch (ex) {
      return ResponseResult(
        data: null,
        icon: null,
        msg: null,
        success: false,
      );
    }
  }

  Future<ResponseResult> changeCouponState(String id, bool state) async {
    try {
      var res = await dio.put('coupons/state', data: {
        "couponId": id,
        "state": state,
      });
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
          internet: true,
          success: false,
        );
      }

      if (res.statusCode == 401) {
        return ResponseResult(
          data: res.data,
          icon: Icons.info,
          msg: "الكوبون المطلوب غير موجود",
          success: false,
        );
      }
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        internet: false,
        success: false,
      );
    }
  }

  Future<ResponseResult> updatePromoCode(PromoCode promoCode) async {
    try {
      var res = await dio.put('coupons', data: {
        "couponId": promoCode.id,
        "name": promoCode.name,
        "maxUsers": promoCode.maxUsers,
        "startingDate": promoCode.startingDate == null
            ? null
            : promoCode.startingDate.toString(),
        "endingDate": promoCode.endingDate == null
            ? null
            : promoCode.endingDate.toString(),
      });
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
          internet: true,
          success: false,
        );
      }

      if (res.statusCode == 401) {
        return ResponseResult(
          data: res.data,
          icon: Icons.info,
          msg: "الكوبون المطلوب غير موجود",
          success: false,
        );
      }
      if (res.statusCode == 402) {
        return ResponseResult(
          data: res.data,
          icon: Icons.copy,
          msg: "يوجد كوبون اخر بنفس الإسم",
          success: false,
        );
      }
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        internet: false,
        success: false,
      );
    }
  }

  Future<ResponseResult> deleteCoupon(String id) async {
    try {
      var res = await dio.delete('coupons', data: {"couponId": id});
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
          internet: true,
          success: false,
        );
      }

      if (res.statusCode == 401) {
        return ResponseResult(
          data: res.data,
          icon: Icons.info,
          msg: "الكوبون المطلوب غير موجود",
          success: false,
        );
      }
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        internet: false,
        success: false,
      );
    }
  }
}
