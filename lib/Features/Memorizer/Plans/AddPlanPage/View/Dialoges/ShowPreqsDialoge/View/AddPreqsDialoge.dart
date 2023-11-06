import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomTextBox.dart';

class AddPreqsDialoge extends StatelessWidget {
  const AddPreqsDialoge({super.key});

  @override
  Widget build(BuildContext context) {
    String txt = "";
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppText('إاضافة متطلب للدورة'),
            const SizedBox(height: 20),
            CustomTextBox(
              hintText: "اكتب هنا",
              onChanged: (e) => txt = e,
              maxLines: null,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 100,
              child: CustomButton(
                text: 'تم',
                icon: const Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                verticalPadding: 5,
                onTap: () {
                  Get.back<String>(result: txt);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
