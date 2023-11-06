import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../../GeneralWidgets/AppText.dart';
import '../../../../../GeneralWidgets/CustomUserImage.dart';
import '../../../../../Models/User.dart';
import '../../../../../Shared/Fonts/FontModel.dart';
import '../../../../../services/AppUser.dart';
import '../../../../Core/QrScanner/View/QrScanner.dart';
import '../../Cubits/HomeCubit/home_cubit.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.onOpenDrawer,
  });
  final VoidCallback onOpenDrawer;
  @override
  Widget build(BuildContext context) {
    final User user = Get.find<AppUser>().user!;
    final cubit = context.read<HomeCubit>();
    return Row(
      children: [
        IconButton(
          onPressed: onOpenDrawer,
          icon: const Icon(Icons.menu),
        ),
        GestureDetector(
          onTap: cubit.onProfileImageTap,
          child: CustomUserImage(
            url: user.profilePic,
            radius: 23,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              'مرحبا!',
              style: TextStyle(
                fontSize: 19,
                fontFamily: FontFamily.medium,
                height: 0,
              ),
            ),
            AppText(
              user.firstName,
              style: TextStyle(
                fontFamily: FontFamily.bold,
                fontSize: 19,
                height: 0,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Get.to(() => const QrScanner());
          },
          iconSize: 25,
          icon: const Icon(
            Icons.camera_alt_outlined,
          ),
        ),
        IconButton(
          onPressed: () {},
          iconSize: 25,
          icon: const Icon(FontAwesomeIcons.bell),
        ),
      ],
    );
  }
}
