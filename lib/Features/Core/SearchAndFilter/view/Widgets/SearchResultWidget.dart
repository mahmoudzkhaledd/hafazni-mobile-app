import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/SearchAndFilter/Blocs/Search/search_cubit.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomUserImage.dart';
import 'package:hafazni/Models/User.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({
    super.key,
    required this.user,
  });
  final User user;
  Widget buildDesc(IconData icon, String content) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(245, 245, 245, 1),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 19,
            color: const Color.fromRGBO(163, 163, 163, 1),
          ),
          const SizedBox(width: 3),
          AppText(content),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: ListTile(
        onTap: () => context.read<SearchCubit>().toUserPage(user.id),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(0),
        titleTextStyle: TextStyle(
          fontFamily: FontFamily.black,
          fontSize: 15,
          color: Colors.black,
        ),
        title: AppText("${user.firstName}. ${user.lastName[0]}"),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: buildDesc(
                Icons.star,
                user.memorizerData!.rating.toStringAsFixed(1),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: buildDesc(
                Icons.check,
                user.memorizerData!.doneTasks.toString(),
              ),
            ),
          ],
        ),
        subtitle: Column(
          children: [
            const Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 20,
                  color: Colors.black54,
                ),
                AppText(
                  'مصر',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  user.memorizerData!.certificant.isNotEmpty
                      ? Icons.check
                      : Icons.clear,
                  size: 20,
                  color: Colors.black54,
                ),
                AppText(
                  user.memorizerData!.certificant.isNotEmpty
                      ? "حاصل على إجازة"
                      : "لم يحصل على إجازة",
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: CustomUserImage(
          url: user.profilePic,
        ),
      ),
    );
  }
}
