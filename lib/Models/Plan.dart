import 'package:get/get.dart';
import 'package:hafazni/Models/User.dart';
import 'package:hafazni/services/AppUser.dart';

enum PlanState {
  pending,
  accepted,
  refused,
  saved,
  hidden,
}

class Plan {
  String id = "";
  String memorizerFrom = "";
  User memorizerData = User(); //
  String title = ""; //
  String description = ""; //
  int duration = 0;
  int students = 0;
  List<String> preRequisites = [];
  double price = 0;
  double? afterDiscount;
  String? orderid;
  List<String> promoCode = [];
  PlanState state = PlanState.saved;
  Plan();
  String get qrCode => "plan $id";
  Plan.fromJsonSearch(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    price = json['price'] * 1.0;
    orderid = json['orderid'];
    state = PlanState.values.byName(json['state'].toString());
    afterDiscount =
        json['afterDiscount'] != null ? json['afterDiscount'] * 1.0 : null;
  }
  Plan.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    preRequisites = json['preRequisites'].cast<String>();
    price = json['price'] * 1.0;
    orderid = json['orderId'];
    students = json['students'] ?? 0;
    if (json['memorizerFrom'] == Get.find<AppUser>().user!.id) {
      memorizerData = Get.find<AppUser>().user!;
    } else if (json['memorizerFrom'] != null) {
      memorizerData = User.fromJsonSearch(json['memorizerFrom']);
    }

    afterDiscount =
        json['afterDiscount'] != null ? json['afterDiscount'] * 1.0 : null;

    state = PlanState.values.byName(json['state'].toString());

    for (var element in (json['promoCode'] as List<dynamic>)) {
      promoCode.add(element.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id.isNotEmpty) {
      data['id'] = id;
    }
    data['memorizerFrom'] = memorizerFrom;
    data['title'] = title;
    data['duration'] = duration;
    data['preRequisites'] = preRequisites;
    data['description'] = description;
    data['price'] = price;
    data['state'] = state.name;
    data['afterDiscount'] = afterDiscount;
    data['promoCode'] = promoCode.map<String>((e) => e).toList();
    return data;
  }
}
