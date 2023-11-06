class Wallet {
  String id = "";
  String userId = "";
  double pending = 0; //
  double spent = 0;  // 
  double balance = 0; //
  double earn = 0; //
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  Wallet();

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    pending = json['pending'] * 1.0;
    spent = json['spent'] * 1.0;
    balance = json['balance'] * 1.0;
    earn = json['earn'] * 1.0;
    createdAt = DateTime.parse(json['createdAt'].toString());
    updatedAt = DateTime.parse(json['updatedAt'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['userId'] = userId;
    data['pending'] = pending;
    data['spent'] = spent;
    data['balance'] = balance;
    data['earn'] = earn;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
