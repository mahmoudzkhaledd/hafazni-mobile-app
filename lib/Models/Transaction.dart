enum TransactionType {
  deposit,
  withdraw,
  profit,
  pay,
  pend,
}

class Transaction {
  String id = "";
  String walletId = "";
  int number = 0;
  TransactionType operationType = TransactionType.deposit;
  double amount = 0;
  String? note;
  String? orderId;
  bool success = false;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  static String getOperationType(TransactionType type) {
    if (type == TransactionType.deposit) {
      return "إيداع رصيد";
    } else if (type == TransactionType.withdraw) {
      return "سحب أرباح";
    } else if (type == TransactionType.profit) {
      return "تسجيل ارباح";
    } else if (type == TransactionType.pay) {
      return " دفع";
    }
    return "تعليق رصيد";
  }

  Transaction();

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    number = json['number'];
    walletId = json['walletId'];
    operationType =
        TransactionType.values.byName(json['operationType'].toString());
    amount = json['amount'] * 1.0;
    note = json['note'];
    orderId = json['orderId'];
    success = json['success'];
    createdAt = DateTime.parse(json['createdAt'].toString());
    updatedAt = DateTime.parse(json['updatedAt'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['walletId'] = walletId;
    data['operationType'] = operationType.name;
    data['amount'] = amount;
    data['note'] = note;
    data['orderId'] = orderId;
    data['createdAt'] = createdAt.toString();
    data['updatedAt'] = updatedAt.toString();
    return data;
  }
}
