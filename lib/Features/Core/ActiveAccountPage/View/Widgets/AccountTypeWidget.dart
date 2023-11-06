import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/Shared/AppColors.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:hafazni/Shared/SharedTextStyles.dart';
import '../../../../../Models/AccountType.dart';

class AccountTypeWidget extends StatelessWidget {
  const AccountTypeWidget({
    super.key,
    required this.description,
    required this.onTap,
    required this.onSeeReasons,
    required this.state,
  });
  final AccountTypeDescription description;
  final AccountTypeState state;
  final Function(AccountTypeDescription) onTap;
  final Function() onSeeReasons;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(description);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 15,
              offset: Offset(0, 10),
              color: Colors.black26,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 9,
        ),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AppText(
                    description.title,
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 20),
                CustomButton(
                  text: state == AccountTypeState.accepted
                      ? "تم تفعيل"
                      : state == AccountTypeState.pending
                          ? "جاري المراجعة"
                          : state == AccountTypeState.refused
                              ? "تم الرفض"
                              : state == AccountTypeState.saved
                                  ? "تم الحفظ"
                                  : "لم يتم التفعيل",
                  textStyle: TextStyle(
                    fontFamily: FontFamily.bold,
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  onTap: onSeeReasons,
                  verticalPadding: 2.5,
                  horizontalPadding: 10,
                  icon: Icon(
                    state == AccountTypeState.accepted
                        ? Icons.check_circle
                        : state == AccountTypeState.pending
                            ? Icons.lock_clock_outlined
                            : state == AccountTypeState.refused
                                ? Icons.close
                                : state == AccountTypeState.saved
                                    ? Icons.save
                                    : Icons.power_settings_new,
                    size: 20,
                    color: Colors.white,
                  ),
                  backgroundColor: (state == AccountTypeState.accepted ||
                          state == AccountTypeState.saved)
                      ? AppColors.mainColor
                      : state == AccountTypeState.refused
                          ? Colors.red
                          : state == AccountTypeState.pending
                              ? Colors.amber
                              : const Color.fromRGBO(25, 26, 30, 1),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AppText(
              description.content,
              style: TextStyles.subHeaderStyle,
            ),
          ],
        ),
      ),
    );
  }
}
