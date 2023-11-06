import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Models/Message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
    required this.reversed,
  });
  final Message message;
  final bool reversed;
  @override
  Widget build(BuildContext context) {
    final list = [
      const CircleAvatar(),
      const SizedBox(width: 8),
      Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(231, 255, 219, 1),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(!reversed ? 0 : 20),
            topLeft: Radius.circular(reversed ? 0 : 20),
            bottomLeft: const Radius.circular(15),
            bottomRight: const Radius.circular(15),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        constraints: BoxConstraints(
          maxWidth: Helper.size(context).width / 2 - 20,
        ),
        child: AppText(message.content),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            reversed ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: reversed ? list.reversed.toList() : list,
      ),
    );
  }
}
