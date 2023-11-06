import 'package:flutter/material.dart';

import '../../../../../../GeneralWidgets/AppText.dart';
import '../../../../../../GeneralWidgets/CustomContainer.dart';
import '../../../../../../GeneralWidgets/CustomTimeLine.dart';
import '../../../../../../GeneralWidgets/Image.dart';
import '../../../../../../Models/Order.dart';
import '../../../../../../Shared/Fonts/FontModel.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({super.key, required this.state});
  final OrderState state;
  final List<String> desc = const [
    "تتم مراجعة الطلب من خلال فريق الدعم الفني للتأكد من عدم احتوائه على أي شيء خارج نطاق المنصة",
    "تم إرسال الطلب للمحفظ لمراجعته ",
    "وافق المحفظ على الطلب الخاص بكم وبانتظار الدفع الان",
    "رفض المحفظ الطلب الخاص بكم حيث لأنه غير مناسب له",
  ];
  @override
  Widget build(BuildContext context) {
    return CustomTimeLine(
      itemCount: 3,
      separatorHeightBuilder: (idx) => 100,
      builder: (ctx, idx) {
        if (state == OrderState.refused && idx == 2) {
          idx++;
        }
        return Row(
          children: [
            CustomContainer(
              backColor: const Color.fromRGBO(214, 245, 228, 1),
              borderRadius: 10,
              verticalPadding: 7,
              horizontalPadding: 7,
              child: CustomImage(
                '${OrderState.values.elementAt(idx).name}.png',
                width: 35,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    Order.stateName(OrderState.values.elementAt(idx)),
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                      fontSize: 14,
                    ),
                  ),
                  Flexible(
                    child: AppText(
                      desc[idx],
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      horizontalSpace: 20,
      iconBuilder: (ctx, idx) {
        int currIdx = OrderState.values.indexOf(state);
        if (state == OrderState.refused && idx == 2) {
          idx++;
        }
        return Icon(
          idx > currIdx ? Icons.timelapse : Icons.check_circle,
          color: idx > currIdx ? Colors.grey : Colors.green,
        );
      },
      separatorBuilder: (context, idx) {
        if (state == OrderState.refused && idx == 2) {
          idx++;
        }
        return idx < 2
            ? Container(
                width: 6,
                height: idx != 1 ? 80 : 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(102, 217, 147, 1),
                      Color.fromRGBO(180, 237, 204, 1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
