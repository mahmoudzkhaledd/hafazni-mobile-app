import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Auth/LoginPage/View/LoginPage.dart';
import 'package:hafazni/Features/Auth/SignupPage/View/SignupPage.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';
import 'package:hafazni/Shared/SharedTextStyles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              const CustomImage(
                'quran (2).png',
                width: 200,
              ),
              AppText(
                'مرحبا بك في منصة حفظني',
                style: TextStyles.headerStyle,
                textAlign: TextAlign.center,
              ),
              AppText(
                '''
  المنصة المتخصصة في تحفيظ القران الكريم
يوجد لدينا اكبر عدد من المحفظين بجميع القراءات  سجل الدخول او انشئ حساب جديد حتى تدخل عالم منصة حفظني 
''',
                textAlign: TextAlign.center,
                style: TextStyles.subHeaderStyle,
              ),
              CustomButton(
                text: 'تسجيل الدخول',
                onTap: () {
                  Get.to(() => const LoginPage());
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: "انشاء حساب جديد",
                borderd: true,
                borderColor: Colors.black,
                borderWidth: 1.5,
                textColor: Colors.black,
                backgroundColor: Colors.white,
                onTap: () {
                  Get.to(() => const SignupPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
