import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hafazni/Models/Order.dart';
import 'package:hafazni/Models/ResponseResult.dart';

import 'package:hafazni/services/GeneralServices/NetworkService.dart';

class OrdersServices {
  final dio = NetworkService.instance;
  Future<List<Order>> getSentOrders(bool toMe) async {
    var res = await NetworkService.handelRequest(
      future: dio.get(
        "sent-orders?toMe=$toMe",
      ),
    );
    if (res == null) {
      return [];
    }
    if (res.statusCode == 200) {
      List<Order> orders = [];
      for (var x in res.data['orders']) {
        orders.add(Order.fromJson(x));
      }
      return orders;
    }
    return [];
  }

  Future<Order?> getOrder(String id) async {
    var res = await NetworkService.handelRequest(
      future: dio.get("order/$id"),
    );
    if (res == null) {
      return null;
    }
    if (res.statusCode == 200) {
      try {
        return Order.fromJson(res.data['order']);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<ResponseResult> changeOrderState(String id, OrderState state) async {
    var res = await NetworkService.handelRequest(
      future: dio.put(
        "order/$id?state=${state.name}",
      ),
    );

    if (res == null) {
      return ResponseResult(
        data: null,
        icon: null,
        msg: null,
        success: false,
      );
    }
    var ans = ResponseResult(
      data: res.data,
      icon: null,
      msg: "خطأ غير معروف الرجاء اعادة المحاولة",
      success: false,
    );
    switch (res.statusCode) {
      case 0:
        ans.msg = null;
      case 401:
        ans.msg = "الطلب غير موجود";
      case 402:
        ans.msg = "غير مصرح لك بالقيام بهذه العميلة";
      case 403:
        ans.msg =
            "الخطة غير مقبولة, يجب الانتظار لحين قبول الخطة والمحاولة من جديد";
      case 200:
        ans.msg = "تمت العملية بنجاح";
        ans.success = true;
        if (state == OrderState.canceled) {
          await FirebaseMessaging.instance.unsubscribeFromTopic('orders-$id');
        }
    }
    return ans;
  }

  Future<ResponseResult> startPlan(String orderId) async {
    var res = await NetworkService.handelRequest(
      future: dio.post(
        "order/$orderId/start",
      ),
    );
    if (res == null) {
      return ResponseResult(
        data: null,
        icon: null,
        msg: null,
        success: false,
      );
    }
    var ans = ResponseResult(
      data: res.data,
      icon: null,
      msg: null,
      success: false,
    );

    if (res.statusCode == 401) {
      ans.msg = "غير مصرح لك بالقيام بهذه العملية";
    } else if (res.statusCode == 402) {
      ans.msg =
          "رصيدك الحالي لايسمح بإجراء العملية, يرجى الشحن واعادة المحاولة";
    } else if (res.statusCode == 405) {
      ans.msg = "لم يتم تفعيل المحفظة في حسابك, الرجاء التفعيل";
    } else if (res.statusCode == 200) {
      ans.msg = null;
      ans.success = true;
    }

    return ans;
  }
}
