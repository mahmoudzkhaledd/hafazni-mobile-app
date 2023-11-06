import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Core/ActiveAccountPage/Service/AccountTypeService.dart';
import 'package:hafazni/Features/Core/ActiveMemorizerAccountPage/view/ActiveMemorizerAccountPage.dart';
import 'package:hafazni/Features/Core/ActiveUserAccount/View/ActiveUserAccount.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/AccountType.dart';
import 'package:hafazni/Models/ResponseResult.dart';
import 'package:hafazni/Models/User.dart';
import 'package:hafazni/services/AppUser.dart';
import 'package:meta/meta.dart';
import '../../../../../Models/AccountType.dart' as accType;
import '../../View/Widgets/AccountBottomSheet.dart';
import '../../View/Widgets/AccountConditionsWidget.dart';

part 'account_type_state.dart';

class AccountTypeCubit extends Cubit<AccountTypeState> {
  final User user = Get.find<AppUser>().user!;

  final AccountTypeService _service = AccountTypeService();
  AccountTypeCubit() : super(AccountTypeInitial()) {
    refreshUi();
  }

  void refreshUi() {
    emit(AccountTypeLoadedState(
      userState: user.userData == null
          ? accType.AccountTypeState.unActive
          : user.userData!.state,
      memorizerState: user.memorizerData == null
          ? accType.AccountTypeState.unActive
          : user.memorizerData!.state,
    ));
  }

  void getAccountTypes() async {
    emit(AccountTypeLoadingState());
    ResponseResult res = await _service.getAccountTypes();
    if (!res.success) {
      if (res.msg != null) {
        await Helper.showMessage('خطا اثناء الارسال', res.msg ?? "");
      }
      if (!res.internet) {
        refreshUi();
      }
      if (res.callBack != null) {
        res.callBack!();
      }
      return;
    }
    if (res.data['memorizerData'] != null) {
      user.memorizerData = MemorizerData.fromJson(res.data['memorizerData']);
    } else {
      user.memorizerData = null;
    }
    if (res.data['userData'] != null) {
      user.userData = UserData.fromJson(res.data['userData']);
    } else {
      user.userData = null;
    }

    refreshUi();
  }

  void onTapType(AccountTypeDescription type) async {
    await showDialog(
      context: Get.context!,
      builder: (ctx) => AlertDialog(
        content: AccountConditionsWidget(
          type: type,
          onActive: () {
            if (type.type == AccountTypeEnum.memorizer) {
              Get.to(() => const ActiveMemozierAccountPage());
            } else if (type.type == AccountTypeEnum.user) {
              Get.to(() => const AddUserTargetPage());
            }
          },
        ),
      ),
    );
  }

  void onSeeReasons(bool isUser) {
    String state = "";
    String name = "";
    String? reason = "";

    if (isUser) {
      if (user.userData == null) return;
      state = user.userData!.state.name;
      name = "ميزة اهدافك";
    } else {
      if (user.memorizerData == null) return;
      state = user.memorizerData!.state.name;
      name = "حساب محفظ";
      reason = user.memorizerData!.refusedReason;
    }
    Helper.showBottomSheetWidget(AccountBottomSheet(
      accountState: state,
      accountName: name,
      refusedReason: reason,
      onDeleteAccountType: () => deleteAccountType(isUser),
    ));
  }

  void deleteAccountType(bool isUser) async {
    bool ans = await Helper.showYesNoMessage(
      "حذف ${isUser ? "ميزة اهدافك من الحساب؟" : "حساب معلق؟"}",
      "هل انت متأكد من انك تريد حذف البيانات؟",
    );
    if (ans) {
      var res = await Helper.showLoading(
        "جاري الحذف",
        "يرجى الانتظار",
        () => _service.deleteAccountTyep(isUser),
      );
      if (res.success) {
        if (isUser) {
          user.userData = null;
        } else {
          user.memorizerData = null;
        }
        refreshUi();
      }
    }
  }
}
