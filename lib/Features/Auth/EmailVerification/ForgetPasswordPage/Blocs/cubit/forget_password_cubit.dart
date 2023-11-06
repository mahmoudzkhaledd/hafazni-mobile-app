import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Auth/EmailVerification/Service/EmailVerificationService.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  final EmailVerificationService _service = EmailVerificationService();
  String email = "";
  void sendEmail() async {
    if (!email.isEmail) {
      await Helper.showMessage("خطأ", 'من فضلك ادخل ايميل صالح');
      return;
    }
     await Helper.showLoading(
      'جاري الإرسال',
      "من فضلك انتظر قليلا",
      () => _service.resendVerificationEmail(email),
    );
  }
}
