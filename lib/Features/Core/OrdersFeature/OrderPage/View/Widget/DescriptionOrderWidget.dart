import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../GeneralWidgets/AppText.dart';
import '../../../../../../Shared/Fonts/FontModel.dart';
import '../../Blocs/order_page_cubit.dart';

class OrderDescriptionWidget extends StatelessWidget {
  const OrderDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderPageCubit>();
    return ExpansionTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tilePadding: const EdgeInsets.symmetric(horizontal: 20),
      childrenPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      backgroundColor: const Color.fromRGBO(247, 235, 163, 1),
      collapsedBackgroundColor: const Color.fromRGBO(247, 235, 163, 1),
      title: AppText(
        'رسالة للمحفظ',
        style: TextStyle(
          fontFamily: FontFamily.bold,
          fontSize: 15,
        ),
      ),
      expandedAlignment: Alignment.topRight,
      children: [
        AppText(cubit.order.note),
      ],
    );
  }
}
