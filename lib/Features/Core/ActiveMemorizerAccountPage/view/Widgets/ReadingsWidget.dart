import 'package:flutter/material.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:hafazni/Shared/AppReposetory.dart';

import '../../../../../GeneralWidgets/AppText.dart';

class ReadingsWidget extends StatelessWidget {
  const ReadingsWidget({
    super.key,
    required this.onCheck,
    required this.checked,
  });
  final Function(int, bool) onCheck;
  final Map<int, bool> checked;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: AppRepository.readings.length,
        itemBuilder: (ctx, idx) => CheckboxListTile(
          contentPadding: const EdgeInsets.all(0),
          value: checked[idx + 1] ?? false,
          title: DefaultTextStyle(
            style: const TextStyle(),
            child: AppText(
              AppRepository.readings[idx],
              style: TextStyle(
                fontFamily: FontFamily.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          onChanged: (bool? value) {
            onCheck(idx + 1, value ?? false);
          },
        ),
      ),
    );
  }
}
