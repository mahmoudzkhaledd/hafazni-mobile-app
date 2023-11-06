import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Core/BalanceFeature/BalancePage/View/Dialoges/ChargeDialoge/ChargeDialogeCtrl.dart';
import 'package:hafazni/Features/Core/BalanceFeature/BalanceServices/BalanceServices.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/Wallet.dart';
import 'package:hafazni/services/AppUser.dart';
import 'package:meta/meta.dart';

import '../../View/Dialoges/ChargeDialoge/ChargeDialoge.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  late Wallet wallet;
  final BalanceServices _services = BalanceServices();

  BalanceCubit() : super(BalanceLoadingState()) {
    getWallet();
  }
  void getWallet() async {
    emit(BalanceLoadingState());
    var res = await _services.getWallet(Get.find<AppUser>().user!.wallet);

    if (!res.success) {
      if (res.msg != null) {
        await Helper.showMessage(
          'خطأ اثناء التحميل',
          res.msg!,
        );
      }
      emit(BalanceFailedState());
      return;
    }
    if (res.data['wallet'] != null) {
      wallet = Wallet.fromJson(res.data['wallet']);
      emit(BalanceLoadedState());
    } else {
      emit(CreateWalletState());
    }
  }

  void charge() async {
    double? res = await Get.dialog<double>(ChargeDialoge(walletId: wallet.id));
    Get.delete<ChargeDialogeCtrl>();
    if (res != null) {
      wallet.balance = res;
      emit(BalanceLoadedState());
    }
  }

  void pull() {}

  void createWallet() async {
    Wallet? w = await Helper.showLoading<Wallet?>(
      'جاري الانشاء',
      "الرجاء الانتظار قليلا",
      () => _services.createWallet(),
    );
    if (w != null) {
      Get.find<AppUser>().user!.wallet = w.id;
      wallet = w;
      emit(BalanceLoadedState());
    } else {
      await Helper.showMessage(
        'خطأ',
        "حدث خطأ اثناء الانشاء الرجاء اعادة المحاولة",
      );
    }
  }
}
