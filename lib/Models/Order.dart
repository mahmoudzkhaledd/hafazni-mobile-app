import 'package:hafazni/Models/Plan.dart';
import 'package:hafazni/Models/PromoCode.dart';
import 'package:hafazni/Models/User.dart';

enum OrderState {
  pending,
  sent,
  accepted,
  refused,
  canceled,
  running,
}

class Order {
  int number = 0; //
  String id = "";
  String userFrom = "";
  String memorizerTo = "";
  String note = "";
  OrderState state = OrderState.pending; //
  String planId = "";
  PromoCode? promoCode;
  Plan plan = Plan();
  double? afterCoupon;
  User memorizer = User();
  User student = User();
  DateTime createdAt = DateTime.now(); //
  DateTime updatedAt = DateTime.now();
  Order();
  static String stateName(OrderState state) {
    if (state == OrderState.pending) {
      return "بانتظار المراجعة";
    } else if (state == OrderState.sent) {
      return "ارسلت للمحفظ";
    } else if (state == OrderState.accepted) {
      return "بانتظار الدفع";
    } else if (state == OrderState.refused) {
      return "تم الرفض";
    } else if (state == OrderState.canceled) {
      return "تم الإلغاء";
    } else if (state == OrderState.running) {
      return "تم الدفع";
    }
    return "";
  }

  Order.fromJson(Map<String, dynamic> json) {
    id = json['_id'];

    if (json['userFrom'] != null && json['userFrom'] is Map<String, dynamic>) {
      student = User.fromJsonSearch(json['userFrom']);
    } else {
      userFrom = json['userFrom'].toString();
    }
    number = json['number'];

    note = json['note'];

    if (json['memorizerTo'] != null &&
        json['memorizerTo'] is Map<String, dynamic>) {
      memorizer = User.fromJsonSearch(json['memorizerTo']);
      memorizerTo = memorizer.id;
    } else {
      memorizerTo = json['memorizerTo'].toString();
    }

    state = OrderState.values.byName(json['state']);

    if (json['planId'] != null && json['planId'] is Map<String, dynamic>) {
      plan = Plan.fromJsonSearch(json['planId']);
      planId = plan.id;
    } else {
      planId = json['planId'];
    }
    afterCoupon =
        json['afterCoupon'] == null ? null : json['afterCoupon'] * 1.0;
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    if (json['promoCode'] != null &&
        json['promoCode'] is Map<String, dynamic>) {
      promoCode = PromoCode.fromJson(json['promoCode']);
    }
  }

  String get getTitle => 'طلب تحفيظ رقم # $number';

  double get getFinalPrice {
    if (afterCoupon != null) {
      return afterCoupon!;
    } else if (promoCode != null) {
      return promoCode!.applyCoupon(plan.price);
    } else if (plan.afterDiscount != null) {
      return plan.afterDiscount!;
    } else {
      return plan.price;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id.isNotEmpty) {
      data['_id'] = id;
    }
    data['userFrom'] = userFrom;
    data['memorizerTo'] = memorizerTo;
    data['note'] = note;
    data['planId'] = planId;
    data['promoCode'] = promoCode != null ? promoCode!.id : null;
    return data;
  }
}
