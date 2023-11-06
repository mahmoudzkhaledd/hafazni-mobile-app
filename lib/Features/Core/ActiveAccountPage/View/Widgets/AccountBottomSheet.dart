import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';

class AccountBottomSheet extends StatelessWidget {
  const AccountBottomSheet({
    super.key,
    required this.accountState,
    this.refusedReason,
    required this.onDeleteAccountType,
    required this.accountName,
  });
  final String accountName;
  final String accountState;
  final String? refusedReason;
  final Function() onDeleteAccountType;
  Widget customTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) =>
      Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              offset: Offset(0, 5),
              color: Colors.black12,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          titleTextStyle: TextStyle(
            fontFamily: FontFamily.bold,
            fontSize: 16,
            color: Colors.black,
          ),
          title: AppText(title),
          subtitle: AppText(subtitle),
          leading: Icon(icon),
        ),
      );
  @override
  Widget build(BuildContext context) {
    final TextStyle titelStyle = TextStyle(
      fontFamily: FontFamily.bold,
      fontSize: 16,
      color: Colors.black,
    );
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            accountName,
            style: titelStyle,
          ),
          customTile(
            title: accountState,
            subtitle: 'حالة الطلب',
            icon: Icons.info,
          ),
          if (refusedReason != null)
            customTile(
              title: refusedReason!.isEmpty ? "غير معروف" : refusedReason!,
              subtitle: 'سبب الرفض',
              icon: Icons.question_answer,
            ),
          ListTile(
            titleTextStyle: titelStyle,
            title: const AppText("حذف البيانات"),
            leading: const Icon(Icons.delete),
            onTap: onDeleteAccountType,
          ),
        ],
      ),
    );
  }
}
