import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

import '../../Blocs/UserProfileCubit/user_profile_cubit.dart';

class UserRatingWidget extends StatelessWidget {
  const UserRatingWidget({super.key});
  Widget buildRating(String title, int rating) => CustomContainer(
        borderRadius: 20,
        verticalPadding: 10,
        horizontalPadding: 15,
        marginBottom: 15,
        backColor: const Color.fromRGBO(251, 244, 205, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: AppText(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            //const Spacer(),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star_rounded,
                  color: index < rating
                      ? const Color.fromRGBO(225, 117, 37, 1)
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserProfileCubit>();

    return ExpansionTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tilePadding: const EdgeInsets.symmetric(horizontal: 20),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: const Color.fromRGBO(247, 235, 163, 1),
      collapsedBackgroundColor: const Color.fromRGBO(247, 235, 163, 1),
      trailing: CustomContainer(
        backColor: const Color.fromRGBO(239, 164, 57, 1),
        width: 70,
        borderRadius: 20,
        verticalPadding: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              cubit.user.memorizerData!.rating.toStringAsFixed(1),
              style: TextStyle(
                fontFamily: FontFamily.black,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const Icon(
              Icons.star_rounded,
              color: Colors.white,
            ),
          ],
        ),
      ),
      
      title: const AppText(
        'التقييم',
        style: TextStyle(
          fontSize: 17,
        ),
      ),
      leading: const Icon(
        Icons.check_circle,
        color: Color.fromRGBO(234, 116, 64, 1),
      ),
      children: [
        buildRating("سرعة الرد", 4),
        buildRating("صوت المحفظ", 2),
        buildRating("سرعة التحفيظ", 5),
        buildRating("إجادة القراءات المحددة", 1),
      ],
    );
  }
}
