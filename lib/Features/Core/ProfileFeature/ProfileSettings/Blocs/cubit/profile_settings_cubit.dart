import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Core/ProfileFeature/Service/UserProfileService.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/User.dart';
import 'package:hafazni/services/AppUser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../../../GeneralWidgets/Dialoges/CountriesDialoge/Controller/ContriesController.dart';
import '../../../../../../GeneralWidgets/Dialoges/CountriesDialoge/view/CountriesDialoge.dart';
import '../../../../../../GeneralWidgets/Dialoges/UploadingDialoge/Ctrl/UploadingDialogeCtrl.dart';
import '../../../../../../GeneralWidgets/Dialoges/UploadingDialoge/View/UploadingDialoge.dart';
import '../../../../../../Models/Country.dart';

part 'profile_settings_state.dart';

class ProfileSettingsCubit extends Cubit<ProfileSettingsState> {
  late final User user;
  final UserProfileService _profileService = UserProfileService();
  final formKey = GlobalKey<FormState>();
  ProfileSettingsCubit() : super(ProfileSettingsInitial()) {
    user = Get.find<AppUser>().user!.copy();
  }

  void changeUserGender(bool? val) {
    if (val != null && val != user.gender) {
      user.gender = val;
      emit(ChangeGenderSettingsState());
    }
  }

  void removePic() {
    emit(ChangeImageState(null));
  }

  void choosePic() async {
    // ignore: invalid_use_of_visible_for_testing_member
    var file = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);
    if (file != null) {
      emit(ChangeImageState(file));
    }
  }

  void changeUserBirthDate() async {
    DateTime? date = await showDatePicker(
      context: Get.context!,
      initialDate: user.birthdate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      user.birthdate = date;
      emit(ChangeBirthdateSettingsState());
    }
  }

  void changeCountry() async {
    Get.put(CountriesController([], chooseOne: true));
    Country? res = await Get.dialog(const CountryDialoge());
    Get.delete<CountriesController>();
    if (res != null) {
      user.country = res;
      emit(ChangeCountrySettingsState());
    }
  }

  void editProfile() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    var res = await Helper.showLoading(
      'يرجى الانتظار',
      "جاري تحديث بياناتك",
      () => _profileService.updateProfile(user),
    );

    if (!res.success) {
      await Helper.showMessage(
        'خطأ اثناء الارسال',
        "حدث خطأ غير متوقع, الرجاء المحاولة من جديد",
      );
      return;
    }
    await Helper.showMessage(
      "عملية ناجحة",
      "تم تحديث البروفايل الخاص بك بنجاح",
      icon: Icons.check_circle,
    );
    Get.find<AppUser>().user!.firstName = user.firstName;
    Get.find<AppUser>().user!.lastName = user.lastName;
    Get.find<AppUser>().user!.phone = user.phone;
    Get.find<AppUser>().user!.birthdate = user.birthdate;
    Get.find<AppUser>().user!.country = user.country;
    Get.find<AppUser>().user!.gender = user.gender;
  }

  void uploadPhoto() async {
    if (state is ChangeImageState &&
        (state as ChangeImageState).image != null) {
      final ctrl = Get.put(UploadingCtrl());
      Get.dialog(
        const UploadingDialoge(),
      );
      var res = await _profileService.uploadPhoto(
        (state as ChangeImageState).image!,
        ctrl.onChanged,
      );
      Get.back();
      Get.delete<UploadingCtrl>();
      if (!res.success) {
        if (res.msg != null) {
          await Helper.showMessage(
            'خطأ في حجم الملف',
            res.msg!,
          );
        } else {
          await Helper.showMessage(
            'خطأ في حجم الملف',
            "خطأ غير معروف الرجاء اعادة المحاولة",
          );
        }
      } else {
        Get.find<AppUser>().user!.profilePic = res.data['url'];
        user.profilePic = res.data['url'];
        emit(ChangeImageState(null));
      }
    }
  }

  void removePicOnline() async {
    bool res = await Helper.showYesNoMessage(
      'حذف الصورة',
      "هل أنت متأكد من حذف الصورة؟",
      icon: FontAwesomeIcons.trash,
    );
    if (!res) {
      return;
    }
    bool ans = await Helper.showLoading(
      "جاري الحذف",
      "من فضلك انتظر قليلا",
      () => _profileService.deleteImage(),
    );
    if (ans) {
      Get.find<AppUser>().user!.profilePic = "";
      user.profilePic = "";
      emit(ChangeImageState(null));
    }
  }
}
