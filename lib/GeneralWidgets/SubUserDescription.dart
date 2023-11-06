import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Features/Core/ProfileFeature/UserProfile/View/UserProfile.dart';
import 'AppText.dart';
import 'CustomContainer.dart';
import 'CustomUserImage.dart';

class SubUserDescription extends StatelessWidget {
  const SubUserDescription({
    super.key,
    required this.id,
    required this.profilePic,
    required this.fullName,
    required this.goToUserPage,
  });
  final String id;
  final String profilePic;
  final String fullName;
  final bool goToUserPage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!goToUserPage) return;
        Get.to(() => UserProfilePage(userId: id));
      },
      child: CustomContainer(
        backColor: const Color.fromRGBO(250, 250, 250, 1),
        verticalPadding: 5,
        horizontalPadding: 15,
        borderRadius: 10,
        constraints: const BoxConstraints(
          maxWidth: 160,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomUserImage(
              url: profilePic,
              radius: 14,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: AppText(
                fullName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
