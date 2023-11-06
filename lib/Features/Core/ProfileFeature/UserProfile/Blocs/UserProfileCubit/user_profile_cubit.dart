import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlansPage/View/PlansPage.dart';
import 'package:hafazni/Models/User.dart';
import 'package:meta/meta.dart';

import '../../../../../../GeneralWidgets/QrCodeDialoge.dart';
import '../../../Service/UserProfileService.dart';


part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  late User user;
  final UserProfileService _profileService = UserProfileService();
  final String userId;
  final bool showPlans;
  UserProfileCubit(this.userId, this.showPlans) : super(UserLoadingState()) {
    getUser();
  }
  void getUser() async {
    emit(UserLoadingState());
    var res = await _profileService.loadUser(userId);

    if (!res.success) {
      emit(UserFailedState());
      return;
    }
    try {
      user = User.fromJson(res.data['user']);
      if (user.memorizerData != null) {
        user.memorizerData!.certificant = "";
      }
    } catch (_) {
      emit(UserFailedState());
      return;
    }
    emit(UserLoadedState());
  }

  void getPlansPage() {
    Get.to(() => PlansPage(
          userId: user.id,
        ));
  }

  void showQrCode() {
    Get.dialog(QrCodeDialoge(
      data: user.getQrCode,
    ));
  }
}
