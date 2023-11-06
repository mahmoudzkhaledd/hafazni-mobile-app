import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hafazni/Models/Order.dart';
import 'package:hafazni/Models/PromoCode.dart';
import 'package:hafazni/Models/ResponseResult.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';

import '../../../Models/Plan.dart';

class PlanService {
  final dio = NetworkService.instance;
  Future<ResponseResult> getUserPlans(String? userId) async {
    try {
      var res = await dio.get("plans/user/${userId ?? "all"}");
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
        msg: null,
        success: false,
      );
    }
  }

  Future<ResponseResult> addPlan(Plan plan) async {
 
    try {
      var res = await dio.post(
        'plans',
        data: plan.toJson(),
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
      return ResponseResult(
        data: res.data,
        icon: null,
        msg: null,
        success: false,
      );
    }
  }

  Future<ResponseResult> hidePlan(String id) async {
    try {
      var res = await dio.delete("plans/$id");
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
          msg: "ليس مصرحا لك بالقيام بهذه العملية",
          success: false,
        );
      } else if (res.statusCode == 402) {
        return ResponseResult(
          data: res.data,
          icon: Icons.info,
          msg: "تحتوي الخطة على عدة طلبات الرجاء متابعتها اولا",
          success: false,
        );
      }
      return ResponseResult(
        data: res.data,
        icon: Icons.info,
        msg: "خطأ غير معروف الرجاء اعادة المحاولة",
        success: false,
      );
    }
  }

  Future<PromoCode?> getPlanPromoCode(String code, String planId) async {
    try {
      var res = await dio.get('plans/$planId/promoCode?code=$code');
      return PromoCode.fromJson(res.data);
    } on DioException catch (_) {
      return null;
    }
  }

  Future<ResponseResult> sendOrderRequest(Order order) async {
    try {
      var res = await dio.post(
        'plans/${order.planId}/order',
        data: order.toJson(),
      );
      if (res.statusCode == 200) {
       
        await FirebaseMessaging.instance
            .subscribeToTopic('orders-${res.data['order']['_id']}');
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
          internet: true,
          success: false,
        );
      }

      if (res.statusCode == 401) {
        return ResponseResult(
          data: res.data,
          icon: Icons.info,
          msg: "الخطة المطلوبة غير موجودة",
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

  Future<Plan?> getPlan(String id) async {
    try {
      var res = await dio.get("plans/$id");
      if (res.data['order'] != null) {
        res.data['plan']['orderId'] = res.data['order']['_id'];
      }
      return Plan.fromJson(res.data['plan']);
    } on DioException catch (_) {
      return null;
    }
  }
}
