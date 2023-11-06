import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hafazni/Configs.dart';
import 'package:hafazni/Features/Auth/SplashScreen/View/SplashScreen.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'GeneralWidgets/AppText.dart';
import 'Shared/AppColors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configs();
  runApp(const Hafazni());
}

class Hafazni extends StatelessWidget {
  const Hafazni({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(
        AppText.defaultLanguage == TextLanguage.arabic ? 'ar' : "en",
      ),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar"),
        Locale("en"),
      ],
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            fontFamily: FontFamily.bold,
            fontSize: 17,
            color: Colors.black,
          ),
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
