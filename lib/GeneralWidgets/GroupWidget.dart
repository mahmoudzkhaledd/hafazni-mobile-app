import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';
import 'package:hafazni/Models/Group.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:intl/intl.dart';

class GroupWidget extends StatelessWidget {
  const GroupWidget({
    super.key,
    required this.group,
  });
  final Group group;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 9,
            offset: Offset(0, 5),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomImage(
            'group-users.png',
            width: 50,
          ),
          const SizedBox(width: 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                group.name,
                style: TextStyle(
                  fontFamily: FontFamily.bold,
                  fontSize: 16,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "المحفظ: ",
                      style: TextStyle(
                        fontFamily: FontFamily.regular,
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: "محمود خالد",
                      style: TextStyle(
                        fontFamily: FontFamily.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "تاريخ البدء: ",
                      style: TextStyle(
                        fontFamily: FontFamily.regular,
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: DateFormat("dd/MM/yyyy").format(group.startedAt),
                      style: TextStyle(
                        fontFamily: FontFamily.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
