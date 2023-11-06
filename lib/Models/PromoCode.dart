class PromoCode {
  String id = "";
  String userId = "";
  String code = ""; //
  String name = ""; //

  int users = 0; //
  int productsUseIt = 0;
  int? maxUsers; //
  double discount = 0; //
  bool percentage = false; //
  bool valid = false; //
  DateTime? startingDate; //
  DateTime? endingDate; //

  double applyCoupon(double val) {
    if (percentage) {
      return (1 - discount / 100) * val;
    }
    return val - discount;
  }

  PromoCode();
  PromoCode copy() {
    PromoCode c = PromoCode();
    c.id = id;
    c.name = name;
    c.code = code;
    c.userId = userId;
    c.users = users;
    c.productsUseIt = productsUseIt;
    c.percentage = percentage;
    c.maxUsers = maxUsers;
    c.discount = discount;
    c.valid = valid;
    c.startingDate = startingDate;
    c.endingDate = endingDate;
    return c;
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "maxUsers": maxUsers,
        "discount": discount,
        "percentage": percentage,
        "startingDate": startingDate == null ? null : startingDate.toString(),
        "endingDate": endingDate == null ? null : endingDate.toString(),
      };
  PromoCode.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    code = json['code'];
    userId = json['userId'];
    maxUsers = json['maxUsers'];
    name = json['name'];
    users = int.parse(json['users'].toString());
    productsUseIt = int.parse(json['productsUseIt'].toString());
    discount = double.parse(json['discount'].toString());
    percentage = json['percentage'];
    valid = json['valid'];
    if (json['startingDate'] != null) {
      startingDate = DateTime.parse(json['startingDate'].toString());
    }
    if (json['endingDate'] != null) {
      endingDate = DateTime.parse(json['endingDate'].toString());
    }
  }
}
