import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hafazni/Helper/Helper.dart';

import '../../../../../../../../GeneralWidgets/AppText.dart';
import '../../../../../../../../GeneralWidgets/CustomContainer.dart';
import '../../../../../../../../GeneralWidgets/Image.dart';
import '../Ctrls/ShowPreqsDialogeCtrl.dart';

class ShowPreqsDialoge extends GetView<ShowPreqsDialogeCtrl> {
  ShowPreqsDialoge({
    super.key,
    required List<String> preqs,
  }) {
    Get.put(ShowPreqsDialogeCtrl(preqs));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        constraints: BoxConstraints(maxHeight: Helper.size(context).height / 2),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const AppText('متطلبات الدورة'),
                  const Spacer(),
                  IconButton(
                    onPressed: controller.addPreqs,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              GetBuilder<ShowPreqsDialogeCtrl>(
                builder: (ctrl) {
                  if (ctrl.preqs.isEmpty) {
                    return const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: CustomImage(
                            'empty-box.png',
                            width: 140,
                          ),
                        ),
                        AppText("لم يتم إضافة متطلبات"),
                      ],
                    );
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: ctrl.preqs
                        .map(
                          (e) => CustomContainer(
                            key: UniqueKey(),
                            verticalPadding: 8,
                            horizontalPadding: 20,
                            marginBottom: 20,
                            borderRadius: 10,
                            backColor: Colors.white,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      const Icon(Icons.check),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: AppText(e),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    ctrl.removePreqs(e);
                                  },
                                  icon: const Icon(Icons.remove_circle),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
