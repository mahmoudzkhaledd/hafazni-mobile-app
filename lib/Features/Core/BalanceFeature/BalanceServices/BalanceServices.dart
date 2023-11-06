import 'package:dio/dio.dart';
import 'package:hafazni/Models/ResponseResult.dart';
import 'package:hafazni/Models/Transaction.dart';
import 'package:hafazni/Models/Wallet.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';

class BalanceServices {
  final dio = NetworkService.instance;
  Future<ResponseResult> getWallet(String walletId) async {
    var res = await NetworkService.handelRequest(
      future: dio.get(
        'wallet',
        data: {
          "walletId": walletId,
        },
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
      msg: 'لم يتم انشاء محفظة بعد',
      success: false,
    );
  }

  Future<Response?> charge(double d, String walletId) async {
    var res = await NetworkService.handelRequest(
      future: dio.post(
        'wallet/charge',
        data: {
          "price": d,
          "walletId": walletId,
        },
      ),
    );
    return res;
  }
  // /wallet/transactions

  Future<List<Transaction>?> getTransactions() async {
    var res = await NetworkService.handelRequest(
      future: dio.get('/wallet/transactions'),
    );
    if (res == null || res.statusCode != 200) {
      return null;
    }
    if (res.statusCode == 200) {
      List<Transaction> trans = [];
      for (var i in res.data['transactions']) {
        trans.add(Transaction.fromJson(i));
      }
      return trans;
    }
    return null;
  }

  Future<Wallet?> createWallet() async {
    var res = await NetworkService.handelRequest(
      future: dio.post('wallet/create'),
    );
    if (res == null) {
      return null;
    }

    if (res.statusCode == 200) {
      return Wallet.fromJson(res.data['wallet']);
    }
    return null;
  }
}
