import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hafazni/services/GeneralServices/NotificationService.dart';
import 'firebase_options.dart';
import 'GeneralWidgets/AppText.dart';
import 'Shared/Secrets.dart';
import 'Shared/AppReposetory.dart';
import 'services/AppUser.dart';
import 'services/GeneralServices/NetworkService.dart';
import 'services/GeneralServices/StorageService.dart';

Future<void> handelMsgs(RemoteMessage message) async {
  //print(message.data);
}

Future<void> configs() async {
  Secrets.appMode = kDebugMode ? ApplicationMode.dev : ApplicationMode.run;
  AppText.defaultLanguage = TextLanguage.arabic;
  await StorageServices.instance.initPrefs();
  NetworkService.initDio();
  await AppRepository.init();
  Get.put(AppUser());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission();
  Get.find<AppUser>().deviceToken =
      await FirebaseMessaging.instance.getToken() ?? "";

  FirebaseMessaging.onMessage.listen((event) {
    NotifiactionServices.instance.sendNotification(
      event.notification!.title!,
      event.notification!.body!,
    );
  });
  FirebaseMessaging.onBackgroundMessage(handelMsgs);
  await NotifiactionServices.instance.init();

  //PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // String appName = packageInfo.appName;
  // String packageName = packageInfo.packageName;
  // String version = packageInfo.version;
  // String buildNumber = packageInfo.buildNumber;
}
