import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/GroupWidget.dart';
import 'package:hafazni/Models/Group.dart';
import 'package:hafazni/Shared/SharedTextStyles.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';

class RunningPrograms extends StatelessWidget {
  const RunningPrograms({
    super.key,
    required this.groups,
  });
  final List<Group> groups;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppText(
              'مجموعات جارية',
              style: TextStyles.headerStyle.copyWith(fontSize: 20),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                if (kDebugMode) {
                  print(NetworkService.accessToken);
                }
                //NetworkService.refreshAccessToken('token');
              },
            ),
          ],
        ),
        const SizedBox(height: 6),
        ...groups.map((e) => GroupWidget(group: e)),
      ],
    );
  }
}
