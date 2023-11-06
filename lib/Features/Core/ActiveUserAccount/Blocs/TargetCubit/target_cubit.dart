import 'dart:async';
import 'package:flutter/src/services/text_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Core/ActiveUserAccount/Service/TargetService.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/Surah.dart';
import 'package:hafazni/Shared/AppReposetory.dart';
import 'package:meta/meta.dart';

part 'target_state.dart';

class TargetCubit extends Cubit<TargetState> {
  TargetCubit() : super(TargetInitial());
  Surah? first;
  Surah? second;
  final TargetService _service = TargetService();
  FutureOr<Iterable<Surah>> loadSuras(TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return const Iterable.empty();
    }
    return AppRepository.suras.where(
      (element) => element.name.contains(textEditingValue.text),
    );
  }

  void confirmFirst(Surah p1) {
    first = p1;
  }

  void confirmSecond(Surah p1) {
    second = p1;
  }

  void confirmSurah() {
    emit(TargetInitial());
  }

  submitFirst(String p1) {
    Surah? s = AppRepository.suras.firstWhereOrNull(
      (element) => element.name.contains(p1),
    );
    first = s;
  }

  submitSecond(String p1) {
    Surah? s = AppRepository.suras.firstWhereOrNull(
      (element) => element.name.contains(p1),
    );
    second = s;
  }

  void save() async {
    if (first != null && second != null) {
      var res = await Helper.showLoading(
        "جاري الارسال",
        "يرجى الانتظار",
        () => _service.updateTarget(first!.number, second!.number),
      );
      if (!res.success) {
        await Helper.showMessage(
          "خطأ اثناء الارسال",
          res.msg ?? "خطا غير معروف, يرجى اعادة المحاولة",
          icon: res.icon,
        );
        if (res.callBack != null) {
          res.callBack!();
        }
        return;
      } else {
        await Helper.showMessage(
          "عميلة ناجحة",
          "تم التعديل بنجاح",
          icon: FontAwesomeIcons.check,
        );
      }
    } else {
      await Helper.showMessage(
        "خطأ تحقق",
        "يرجى التحقق من وضع السور بطريقة صحيحة",
        icon: FontAwesomeIcons.circleExclamation,
      );
    }
  }
}
