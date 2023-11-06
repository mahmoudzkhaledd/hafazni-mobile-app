import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Auth/StartingPage/View/StartingPage.dart';
import 'package:hafazni/Features/Home/HomePage/View/HomePage.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomBackground.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';
import 'package:hafazni/services/GeneralServices/StorageService.dart';
import '../../Services/SplashScreenService.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> fade;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    fade = Tween<double>(begin: 1, end: 0).animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
    WidgetsBinding.instance.addPostFrameCallback(loginTokne);
    super.initState();
  }

  void loginTokne(a) async {
    String? token = StorageServices.instance.getUserToken();

    if (token == null) {
      Get.offAll(() => const LandingPage());
      return;
    }
    NetworkService.refreshAccessToken(token);
    bool res = await SplashScreenService().checkAuth();
    if (res) {
      Get.offAll(() => const HomePage());
    } else {
      Get.offAll(() => const LandingPage());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF61B879),
            Color(0xFF13A78C),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CustomBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                FontAwesomeIcons.bookQuran,
                color: Colors.white,
                size: 115,
              ),
              const SizedBox(height: 10),
              AnimatedBuilder(
                animation: fade,
                builder: (ctx, ani) => FadeTransition(
                  opacity: fade,
                  child: AppText(
                    'حفظني',
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
