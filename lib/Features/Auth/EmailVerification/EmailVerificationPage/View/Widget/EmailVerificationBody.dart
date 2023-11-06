import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomTextBox.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';
import 'package:hafazni/Shared/SharedTextStyles.dart';

import '../../../../../../services/AppUser.dart';
import '../../Blocs/EmailVerificationCubit/email_verification_cubit.dart';

class EmailVerificationBody extends StatelessWidget {
  const EmailVerificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final EmailVerificationCubit cubit = context.read<EmailVerificationCubit>();

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const CustomImage(
              'mail.png',
              width: 200,
            ),
            const SizedBox(height: 20),
            AppText(
              "التحقق من الحساب",
              style: TextStyles.headerStyle,
              textAlign: TextAlign.center,
            ),
            AppText(
              "تم ارسال رسالة مكونة من 6 ارقام الى حسابك ${Get.find<AppUser>().user!.email}",
              style: TextStyles.subHeaderStyle.copyWith(fontSize: 15.6),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomTextBox(
              isNumber: true,
              hintText: '000000',
              letterSpacing: 10,
              textAlign: TextAlign.center,
              onChanged: (e) => cubit.codeStr = e,
              maxLength: 6,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: cubit.resendEmail,
                  child: AppText(
                    "لم تصلك الرسالة؟ الارسال مجددا",
                    style: TextStyles.subHeaderStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            CustomButton(
              text: 'تحقق من الحساب',
              onTap: cubit.verifyEmail,
            ),
            const SizedBox(height: 10),
            AppText(
              "اذا لم تجد الرسالة في البريد, الرجاء البحث في الرسائل المهملة",
              style: TextStyles.subHeaderStyle.copyWith(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
